import 'package:fire_base_project/controllers/auth_controller.dart';
import 'package:fire_base_project/models/attendance_model.dart';
import 'package:fire_base_project/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final AttendanceService _attendanceService = AttendanceService();
  final AuthController _authController = Get.find<AuthController>();

  final Rx<AttendanceModel?> todayAttendance = Rx<AttendanceModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isCheckedIn = false.obs;
  final RxString currentLocation = ''.obs;
  final RxList<AttendanceModel> attendanceHistory = <AttendanceModel>[].obs;
  final RxMap<String, int> monthlyStats = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadTodayAttendance();
    loadAttendanceHistory();
    loadMonthlyStatistics();
  }

  // Load Today's Attendance
  Future<void> loadTodayAttendance() async {
    try {
      isLoading.value = true;
      todayAttendance.value = await _attendanceService.getTodayAttendance(
        _authController.user!.uid,
      );
      isCheckedIn.value = todayAttendance.value != null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load attendance data');
    } finally {
      isLoading.value = false;
    }
  }

  // Check In
  Future<void> checkIn() async {
    try {
      isLoading.value = true;

      // Get location
      String location = await _getLocation();

      await _attendanceService.checkIn(
        userId: _authController.user!.uid,
        location: location,
        notes: null,
      );

      await loadTodayAttendance();

      Get.snackbar(
        'Success',
        'Checked in successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to check in: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Check Out
  Future<void> checkOut() async {
    if (todayAttendance.value == null) {
      Get.snackbar('Error', 'You need to check in first');
      return;
    }

    try {
      isLoading.value = true;

      String location = await _getLocation();

      await _attendanceService.checkOut(
        attendanceId: todayAttendance.value!.id,
        location: location,
      );

      await loadTodayAttendance();

      Get.snackbar(
        'Success',
        'Checked out successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to check out',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get Location
  Future<String> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return 'Location service disabled';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'Location permission denied';
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      currentLocation.value = '${position.latitude}, ${position.longitude}';
      return currentLocation.value;
    } catch (e) {
      return 'Unable to get location';
    }
  }

  // Load Attendance History
  void loadAttendanceHistory() {
    _attendanceService.getAttendanceHistory(_authController.user!.uid).listen((
      history,
    ) {
      attendanceHistory.value = history;
    });
  }

  // Load Monthly Statistics
  Future<void> loadMonthlyStatistics() async {
    try {
      var stats = await _attendanceService.getMonthlyStatistics(
        _authController.user!.uid,
        DateTime.now(),
      );
      monthlyStats.value = stats;
    } catch (e) {
      print('Error loading statistics: $e');
    }
  }
}
