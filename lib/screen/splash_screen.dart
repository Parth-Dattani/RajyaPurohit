import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; // ગૂગલ ફોન્ટ્સ
import '../controllers/splash_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math; // ➔ ✅ મેથ એનિમેશન માટે જરૂરી ઈમ્પોર્ટ ઉમેર્યું ભાઈ
import '../constant/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../controllers/splash_controller.dart'; // તમારો સાચો કંટ્રોલર પાથ ભાઈ
import '../constant/app_colors.dart';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  static const pageId = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ➔ ⚡ અહીં કંટ્રોલરને એક્ટિવ કરો જેથી onInit ચાલુ થાય
    Get.put(SplashController());

    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "મહાદેવ હર",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: AppColors.textOrange,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "આ જ્ઞાતિની ડિજિટલ પહેલ માં આપનું સ્વાગત છે.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  height: 1.5,
                  color: AppColors.accentDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// class SplashScreen extends GetView<SplashController> {
//   static const pageId = "/SplashScreen";
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     if (!Get.isRegistered<SplashController>()) {
//       Get.put(SplashController());
//     }
//
//     // ➔ ⚡ બંને લાઇન માટે અલગ અલગ સ્ટાઇલ વેરિયેબલ્સ
//     const titleStyle = TextStyle(
//       fontSize: 40, // મોટો ફોન્ટ
//       fontWeight: FontWeight.bold,
//       letterSpacing: 2.0,
//     );
//
//     const subtitleStyle = TextStyle(
//       fontSize: 18, // નાનો ફોન્ટ
//       fontWeight: FontWeight.w600,
//       letterSpacing: 0.5,
//       height: 1.5,
//     );
//
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.light,
//       ),
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             color: AppColors.background,
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // ==========================================
//                   // 🚩 પહેલી લાઇન: મહાદેવ હર (Big & AppColors.textOrange)
//                   // ==========================================
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Text(
//                         "મહાદેવ હર",
//                         textAlign: TextAlign.center,
//                         style: titleStyle.copyWith(
//                           foreground: Paint()
//                             ..style = PaintingStyle.stroke
//                             ..strokeWidth = 1.2
//                             ..color = AppColors.textOrange,
//                         ),
//                       ),
//                       AnimatedBuilder(
//                         animation: controller.waveController,
//                         builder: (context, child) {
//                           return ClipPath(
//                             clipper: SmoothVideoWaveClipper(
//                               heightPercent: controller.waveHeightAnimation.value,
//                               shiftValue: controller.waveShiftAnimation.value,
//                             ),
//                             child: Text(
//                               "મહાદેવ હર",
//                               textAlign: TextAlign.center,
//                               style: titleStyle.copyWith(
//                                 color: AppColors.textOrange,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   // ==========================================
//                   // 📄 બીજી લાઇન: ડિજિટલ પહેલ (Small & AppColors.accentDark)
//                   // ==========================================
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Text(
//                         "આ જ્ઞાતિની ડિજિટલ પહેલ માં આપનું સ્વાગત છે.",
//                         textAlign: TextAlign.center,
//                         style: subtitleStyle.copyWith(
//                           foreground: Paint()
//                             ..style = PaintingStyle.stroke
//                             ..strokeWidth = 1.0
//                             ..color = AppColors.accentDark,
//                         ),
//                       ),
//                       AnimatedBuilder(
//                         animation: controller.waveController,
//                         builder: (context, child) {
//                           return ClipPath(
//                             clipper: SmoothVideoWaveClipper(
//                               heightPercent: controller.waveHeightAnimation.value,
//                               shiftValue: controller.waveShiftAnimation.value,
//                             ),
//                             child: Text(
//                               "આ જ્ઞાતિની ડિજિટલ પહેલ માં આપનું સ્વાગત છે.",
//                               textAlign: TextAlign.center,
//                               style: subtitleStyle.copyWith(
//                                 color: AppColors.accentDark,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // --- CUSTOM CLIPPER FOR THE EXACT VIDEO SMOOTH WAVE ---
// class SmoothVideoWaveClipper extends CustomClipper<Path> {
//   final double heightPercent;
//   final double shiftValue;
//
//   SmoothVideoWaveClipper({
//     required this.heightPercent,
//     required this.shiftValue,
//   });
//
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0, size.height);
//
//     final currentHeight = size.height * heightPercent;
//     path.lineTo(0, currentHeight);
//
//     for (double x = 0; x <= size.width; x++) {
//       final y = currentHeight + math.sin(shiftValue + (x * 0.03)) * 3.5;
//       path.lineTo(x, y);
//     }
//
//     path.lineTo(size.width, size.height);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant SmoothVideoWaveClipper oldDelegate) {
//     return oldDelegate.heightPercent != heightPercent || oldDelegate.shiftValue != shiftValue;
//   }
// }