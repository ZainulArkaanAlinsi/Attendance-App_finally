import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Collections
  CollectionReference get usersCollection => firestore.collection('users');
  CollectionReference get attendanceCollection =>
      firestore.collection('attendance');
  CollectionReference get leaveRequestsCollection =>
      firestore.collection('leave_requests');
}
