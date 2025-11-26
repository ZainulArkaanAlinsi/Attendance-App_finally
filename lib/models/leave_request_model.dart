import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveRequestModel {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String type; // 'sick', 'annual', 'emergency'
  final String status; // 'pending', 'approved', 'rejected'
  final DateTime createdAt;
  final String? rejectionReason;

  LeaveRequestModel({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.type,
    required this.status,
    required this.createdAt,
    this.rejectionReason,
  });

  factory LeaveRequestModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return LeaveRequestModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      reason: data['reason'] ?? '',
      type: data['type'] ?? 'annual',
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      rejectionReason: data['rejectionReason'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'reason': reason,
      'type': type,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'rejectionReason': rejectionReason,
    };
  }

  int get daysCount {
    return endDate.difference(startDate).inDays + 1;
  }
}
