// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/onBoarding_controller.dart';

// class OnboardingPage extends StatelessWidget {
//   OnboardingPage({super.key});
//   final OnboardingController onboardingController = Get.put(
//     OnboardingController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             PageView(
//               controller: onboardingController.pageController,
//               onPageChanged: onboardingController.onPageChanged,
//               children: [
//               children: onboardingController.data
//                     .map(
//                       (data) => Padding(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               data.imageAsset,
//                               width: 240,
//                               height: 240,
//                               fit: BoxFit.contain,
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               data.description,
//                               style: Theme.of(context).textTheme.bodyLarge,
//                               textAlign: TextAlign.center,
//                             ),
//                             Text(data.description),
//                           ],
//                         ),
//                       ),
//                     )
//                     .toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
