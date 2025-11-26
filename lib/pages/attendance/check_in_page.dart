import 'package:fire_base_project/controllers/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.find<AttendanceController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Check In/Out')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                final now = DateTime.now();
                return Column(
                  children: [
                    Text(
                      DateFormat('HH:mm:ss').format(now),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('EEEE, MMMM dd, yyyy').format(now),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                );
              }),
              const SizedBox(height: 60),
              Obx(() {
                final isCheckedIn = controller.isCheckedIn.value;
                return ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          if (isCheckedIn) {
                            controller.checkOut();
                          } else {
                            controller.checkIn();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    isCheckedIn ? 'Check Out' : 'Check In',
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
