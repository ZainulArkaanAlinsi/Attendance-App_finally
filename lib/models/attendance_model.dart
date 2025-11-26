import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String id;
  final String userId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final String? checkInLocation;
  final String? checkOutLocation;
  final String? checkInPhoto;
  final String? checkOutPhoto;
  final String status; // 'present', 'late', 'absent'
  final String? notes;

  AttendanceModel({
    required this.id,
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
    this.checkInLocation,
    this.checkOutLocation,
    this.checkInPhoto,
    this.checkOutPhoto,
    required this.status,
    this.notes,
  });

  factory AttendanceModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return AttendanceModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      checkInTime: (data['checkInTime'] as Timestamp).toDate(),
      checkOutTime: data['checkOutTime'] != null
          ? (data['checkOutTime'] as Timestamp).toDate()
          : null,
      checkInLocation: data['checkInLocation'],
      checkOutLocation: data['checkOutLocation'],
      checkInPhoto: data['checkInPhoto'],
      checkOutPhoto: data['checkOutPhoto'],
      status: data['status'] ?? 'present',
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'checkInTime': Timestamp.fromDate(checkInTime),
      'checkOutTime': checkOutTime != null
          ? Timestamp.fromDate(checkOutTime!)
          : null,
      'checkInLocation': checkInLocation,
      'checkOutLocation': checkOutLocation,
      'checkInPhoto': checkInPhoto,
      'checkOutPhoto': checkOutPhoto,
      'status': status,
      'notes': notes,
    };
  }

  Duration? get workDuration {
    if (checkOutTime != null) {
      return checkOutTime!.difference(checkInTime);
    }
    return null;
  }
}
