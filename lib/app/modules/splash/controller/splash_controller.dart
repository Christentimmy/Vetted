import 'package:Vetted/app/controller/socket_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
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
