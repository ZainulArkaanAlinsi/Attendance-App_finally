// import 'package:fire_base_project/models/onBoarding_info.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../core/routes.dart';

// class OnboardingController extends GetxController {
//   final List<OnBoardingInfo> data = [
//     OnBoardingInfo(
//       imageAsset: 'assets/onboarding/onboarding1.png',
//       title: 'Welcome to Our App',
//       description: 'Discover new features and functionalities.',
//     ),
//     OnBoardingInfo(
//       imageAsset: 'assets/onboarding/bagian2.png',
//       title: 'Stay Connected',
//       description: 'Connect with people around the world.',
//     ),
//     OnBoardingInfo(
//       imageAsset: 'assets/onboarding/onboarding3.png',
//       title: 'Achieve More',
//       description: 'Boost your productivity with our tools.',
//     ),
//   ];

//   final RxInt currentIndex = 0.obs;
//   final PageController pageController = PageController();

//   // onpage changed
//   void onPageChanged(int index) {
//     currentIndex.value = index;
//   }

//   //next page
//   void nextPage() {
//     if (currentIndex.value < data.length - 1) {
//       pageController.nextPage(
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       completeOnboarding();
//     }
//   }

//   //complete onboarding
//   void completeOnboarding() {
//     final box = GetStorage();
//     box.write('IsFirstTime', false);
//     // Navigate to the home screen or perform any final actions
//     Get.offAllNamed(AppRouter.login);
//     Get.snackbar(
//       'Onboarding Completed',
//       'You have successfully completed the onboarding process.',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   @override
//   void onClose() {
//     pageController.dispose();
//     super.onClose();
//   }
// }
