import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fire_base_project/themes/theme_controller.dart';

class ThemeToggler extends StatelessWidget {
  ThemeToggler({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        icon: Icon(
          themeController.themeMode == ThemeMode.dark
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined,
        ),
        onPressed: () {
          themeController.toggleTheme();
        },
      ),
    );
  }
}
