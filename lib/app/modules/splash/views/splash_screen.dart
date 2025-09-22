import 'package:Vetted/app/modules/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 70, 70, 70), Color(0xFF000000)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: splashController.fadeAnimation,
            child: Image.asset(
              'assets/images/v_logo_1.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
