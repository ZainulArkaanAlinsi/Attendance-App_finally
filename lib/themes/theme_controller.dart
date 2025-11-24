import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  void toggleTheme() {
    _themeMode.value = _themeMode.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    _box.write(_key, _themeMode.value == ThemeMode.dark);
  }

  void loadTheme() {
    final bool? isDarkMode = _box.read(_key);
    _themeMode.value = isDarkMode == null
        ? ThemeMode.system
        : isDarkMode
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }
}
