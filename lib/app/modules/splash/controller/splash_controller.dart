import 'package:Vetted/app/controller/socket_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    initializeAnimation();
    super.onInit();
  }

  void initializeAnimation() async {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Scale: pop-out -> pop-in -> settle with bounce
    scaleAnimation = TweenSequence<double>([
      // Pop-out quickly from 0 to 1.15
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.4,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 30,
      ),
      // Pop-in slightly below 1.0
      TweenSequenceItem(
        tween: Tween(
          begin: 1.4,
          end: 0.9,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 20,
      ),
      // Bounce to 1.0
      TweenSequenceItem(
        tween: Tween(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(controller);

    // Keep fade-in
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final userController = Get.find<UserController>();
        userController.getUserDetails();
        userController.getUserStatus();
        final socketController = Get.find<SocketController>();
        socketController.initializeSocket();
      }
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
