import 'package:fire_base_project/pages/attendance/attendance_history_page.dart';
import 'package:fire_base_project/pages/attendance/check_in_page.dart';
import 'package:fire_base_project/pages/auth/login_page.dart';
import 'package:fire_base_project/pages/auth/register_page.dart';
import 'package:fire_base_project/pages/home/home_page.dart';
import 'package:fire_base_project/pages/leave/leave_request_page.dart';
import 'package:fire_base_project/pages/profile/edit_profile_page.dart';
import 'package:fire_base_project/pages/profile/profile_page.dart';
import 'package:fire_base_project/pages/splash_page.dart';
import 'package:get/get.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String checkIn = '/check-in';
  static const String attendanceHistory = '/attendance-history';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String leaveRequest = '/leave-request';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: register,
      page: () => const RegisterPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: checkIn,
      page: () => const CheckInPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: attendanceHistory,
      page: () => const AttendanceHistoryPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfilePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: leaveRequest,
      page: () => const LeaveRequestPage(),
      transition: Transition.rightToLeft,
    ),
  ];
}
