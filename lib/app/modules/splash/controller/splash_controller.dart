import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    initializeAnimation();
    super.onInit();
  }

  void initializeAnimation() async {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
    });
  }


  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

}
