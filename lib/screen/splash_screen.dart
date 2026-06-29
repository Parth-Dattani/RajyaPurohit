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

class SplashScreen extends GetView<SplashController> {
  static const pageId = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SplashController>()) {
      Get.put(SplashController());
    }

    // GoogleFonts વાપરવાથી વેબ અને મોબાઇલ બંનેમાં સેમ પ્રીમિયમ લુક આવશે
    final textStyle = GoogleFonts.cinzel(
      textStyle: const TextStyle(
        fontSize: 44, // Adjusted size to perfectly fit "RAJYAPUROHIT" on all screens
        fontWeight: FontWeight.w700,
        letterSpacing: 4.0, // Elegant premium spacing
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.background, // ➔ ✅ અપડેટેડ: ગ્લોબલ સરફેસ બેકગ્રાઉન્ડ
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // --- LAYER 1: BASE OUTLINE TEXT ---
                Text(
                  'RAJYAPUROHIT',
                  style: textStyle.copyWith(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.5 // Sharp clean outline
                      ..color = AppColors.accent, // ➔ ✅ અપડેટેડ: ગ્લોબલ એક્સેન્ટ ગોલ્ડન/ઓરેન્જ
                  ),
                ),

                // --- LAYER 2: SMOOTH POLYGON-STYLE WAVE FILLED TEXT ---
                AnimatedBuilder(
                  animation: controller.waveController,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: SmoothVideoWaveClipper(
                        heightPercent: controller.waveHeightAnimation.value,
                        shiftValue: controller.waveShiftAnimation.value,
                      ),
                      child: Text(
                        'RAJYAPUROHIT',
                        style: textStyle.copyWith(
                          color: AppColors.accent, // ➔ ✅ અપડેટેડ: ગ્લોબલ એક્સેન્ટ સોલિડ ફિલ
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- CUSTOM CLIPPER FOR THE EXACT VIDEO SMOOTH WAVE ---
class SmoothVideoWaveClipper extends CustomClipper<Path> {
  final double heightPercent;
  final double shiftValue;

  SmoothVideoWaveClipper({
    required this.heightPercent,
    required this.shiftValue,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);

    final currentHeight = size.height * heightPercent;
    path.lineTo(0, currentHeight);

    for (double x = 0; x <= size.width; x++) {
      final y = currentHeight + math.sin(shiftValue + (x * 0.03)) * 3.5;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant SmoothVideoWaveClipper oldDelegate) {
    return oldDelegate.heightPercent != heightPercent || oldDelegate.shiftValue != shiftValue;
  }
}