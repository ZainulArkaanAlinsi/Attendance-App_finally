import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_project/models/attendance_model.dart';
import 'package:fire_base_project/services/firebase_service.dart';
import 'package:get/get.dart';

class AttendanceService {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  // Check In
  Future<void> checkIn({
    required String userId,
    String? location,
    String? photo,
    String? notes,
  }) async {
    DateTime now = DateTime.now();
    DateTime workStartTime = DateTime(
      now.year,
      now.month,
      now.day,
      9,
      0,
    ); // 9 AM

    String status = 'present';
    if (now.isAfter(workStartTime)) {
      status = 'late';
    }

    AttendanceModel attendance = AttendanceModel(
      id: '',
      userId: userId,
      checkInTime: now,
      checkInLocation: location,
      checkInPhoto: photo,
      status: status,
      notes: notes,
    );

    await _firebaseService.attendanceCollection.add(attendance.toMap());
  }

  // Check Out
  Future<void> checkOut({
    required String attendanceId,
    String? location,
    String? photo,
  }) async {
    await _firebaseService.attendanceCollection.doc(attendanceId).update({
      'checkOutTime': Timestamp.now(),
      'checkOutLocation': location,
      'checkOutPhoto': photo,
    });
  }

  // Get Today's Attendance
  Future<AttendanceModel?> getTodayAttendance(String userId) async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    var querySnapshot = await _firebaseService.attendanceCollection
        .where('userId', isEqualTo: userId)
        .where(
          'checkInTime',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
        )
        .where('checkInTime', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return AttendanceModel.fromFirestore(querySnapshot.docs.first);
    }
    return null;
  }

  // Get Attendance History
  Stream<List<AttendanceModel>> getAttendanceHistory(String userId) {
    return _firebaseService.attendanceCollection
        .where('userId', isEqualTo: userId)
        .orderBy('checkInTime', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AttendanceModel.fromFirestore(doc))
              .toList(),
        );
  }

  // Get Monthly Statistics
  Future<Map<String, int>> getMonthlyStatistics(
    String userId,
    DateTime month,
  ) async {
    DateTime startOfMonth = DateTime(month.year, month.month, 1);
    DateTime endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    var querySnapshot = await _firebaseService.attendanceCollection
        .where('userId', isEqualTo: userId)
        .where(
          'checkInTime',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth),
        )
        .where(
          'checkInTime',
          isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth),
        )
        .get();

    int present = 0;
    int late = 0;
    int total = querySnapshot.docs.length;

    for (var doc in querySnapshot.docs) {
      AttendanceModel attendance = AttendanceModel.fromFirestore(doc);
      if (attendance.status == 'present') {
        present++;
      } else if (attendance.status == 'late') {
        late++;
      }
    }

    return {'total': total, 'present': present, 'late': late};
  }
}
