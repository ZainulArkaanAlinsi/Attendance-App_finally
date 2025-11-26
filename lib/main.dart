import 'package:firebase_core/firebase_core.dart';
import 'package:fire_base_project/controllers/auth_controller.dart';
import 'package:fire_base_project/core/routes.dart';
import 'package:fire_base_project/services/firebase_service.dart';
import 'package:fire_base_project/themes/app_theme.dart';
import 'package:fire_base_project/themes/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Init dotenv file
  await dotenv.load(fileName: ".env");
  
  // Init Get Storage
  await GetStorage.init();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Controllers
  Get.put(ThemeController(), permanent: true);
  Get.put(AuthController(), permanent: true);
  Get.put(FirebaseService(), permanent: true);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(
      () => GetMaterialApp(
        title: 'Attendance App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        getPages: AppRouter.routes,
        initialRoute: AppRouter.splash,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}