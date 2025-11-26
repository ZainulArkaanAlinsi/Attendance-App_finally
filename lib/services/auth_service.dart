import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_base_project/models/user_model.dart';
import 'package:fire_base_project/services/firebase_service.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();

  // Sign Up
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseService.auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create user document in Firestore
      await _createUserDocument(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign In
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseService.auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _firebaseService.auth.signOut();
  }

  // Create User Document
  Future<void> _createUserDocument({
    required String uid,
    required String email,
    required String name,
  }) async {
    UserModel user = UserModel(
      uid: uid,
      email: email,
      name: name,
      createdAt: DateTime.now(),
    );

    await _firebaseService.usersCollection.doc(uid).set(user.toMap());
  }

  // Get Current User
  User? get currentUser => _firebaseService.auth.currentUser;

  // Get User Data
  Future<UserModel?> getUserData(String uid) async {
    try {
      var doc = await _firebaseService.usersCollection.doc(uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Update User Profile
  Future<void> updateUserProfile({
    required String uid,
    String? name,
    String? phoneNumber,
    String? department,
    String? position,
    String? photoUrl,
  }) async {
    Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (department != null) data['department'] = department;
    if (position != null) data['position'] = position;
    if (photoUrl != null) data['photoUrl'] = photoUrl;

    await _firebaseService.usersCollection.doc(uid).update(data);
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    await _firebaseService.auth.sendPasswordResetEmail(email: email);
  }
}
