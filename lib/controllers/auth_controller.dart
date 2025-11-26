import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_base_project/core/routes.dart';
import 'package:fire_base_project/models/user_model.dart';
import 'package:fire_base_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final Rx<User?> _user = Rx<User?>(null);
  final Rx<UserModel?> _userData = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  User? get user => _user.value;
  UserModel? get userData => _userData.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) {
    if (user == null) {
      Get.offAllNamed(AppRouter.login);
    } else {
      _loadUserData(user.uid);
      Get.offAllNamed(AppRouter.home);
    }
  }

  Future<void> _loadUserData(String uid) async {
    _userData.value = await _authService.getUserData(uid);
  }

  // Sign Up
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      isLoading.value = true;
      await _authService.signUp(email: email, password: password, name: name);
      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        _getAuthErrorMessage(e.code),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign In
  Future<void> signIn({required String email, required String password}) async {
    try {
      isLoading.value = true;
      await _authService.signIn(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        _getAuthErrorMessage(e.code),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _authService.signOut();
  }

  // Update Profile
  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? department,
    String? position,
  }) async {
    try {
      isLoading.value = true;
      await _authService.updateUserProfile(
        uid: user!.uid,
        name: name,
        phoneNumber: phoneNumber,
        department: department,
        position: position,
      );
      await _loadUserData(user!.uid);
      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password';
      default:
        return 'Authentication failed';
    }
  }
}
