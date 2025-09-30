import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/staggered_column_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllowNotificationScreen extends StatelessWidget {
  AllowNotificationScreen({super.key});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: StaggeredColumnAnimation(
            duration: Duration(milliseconds: 400),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Notification illustration
              Image.asset(
                'assets/images/notifications_illustration.png',
                height: 240,
              ),

              const SizedBox(height: 32),

              const Text(
                'Allow notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Get notifications you may have missed.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: Get.height * 0.3),

              // Allow Button
              CustomButton(
                ontap: () async {
                  await userController.saveUserOneSignalId();
                },
                isLoading: userController.isloading,
                loaderColor: Colors.white,
                child: Text(
                  'Allow',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Skip Button
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoutes.inputNameScreen);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
