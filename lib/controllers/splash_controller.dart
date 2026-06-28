import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/home_screen.dart'; // તમારી હોમ સ્ક્રીનનો પાથ અહિયાં સેટ કરવો

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController waveController;
  late Animation<double> waveHeightAnimation;
  late Animation<double> waveShiftAnimation;

  @override
  void onInit() {
    super.onInit();

    waveController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    )..repeat(reverse: true);

    waveHeightAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.65, end: 0.45), weight: 33),
      TweenSequenceItem(tween: Tween(begin: 0.45, end: 0.55), weight: 22),
      TweenSequenceItem(tween: Tween(begin: 0.55, end: 0.38), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.38, end: 0.50), weight: 25),
    ]).animate(CurvedAnimation(
      parent: waveController,
      curve: Curves.easeInOut,
    ));

    waveShiftAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: waveController, curve: Curves.linear),
    );

    // ✅ ૫ સેકન્ડ પછી ઓટોમેટિક હોમ સ્ક્રીન પર જવા માટેનું ટાઈમર
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(HomeScreen.pageId);// સ્પ્લેશ સ્ક્રીન હટાવીને હોમ પર જશે
    });
  }

  @override
  void onClose() {
    waveController.dispose();
    super.onClose();
  }
}