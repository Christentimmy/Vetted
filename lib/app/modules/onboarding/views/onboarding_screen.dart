import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/staggered_column_animation.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/vetted-on.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.5)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: StaggeredColumnAnimation(
                children: [
                  SizedBox(height: Get.height * 0.16),

                  // Logo + Title with white background
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white, // <-- White background stays
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(
                            'assets/images/v_logo_2.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Vetted',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Get.height * 0.02),

                  Center(
                    child: const Text(
                      'Designed to help men date safely by\nproviding a platform to background check\npotential dates, read reviews, and get advice\nfrom an anonymous community of men',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height * 0.1),
                  CustomButton(
                    ontap: () => Get.toNamed(AppRoutes.loginScreen),
                    isLoading: authController.isGoogleLoading,
                    bgColor: Colors.white,
                    loaderColor: AppColors.primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.envelope),
                        SizedBox(width: 5),
                        Text(
                          'Continue with Email',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  CustomButton(
                    ontap: () async {
                      CherryToast.info(
                        title: const Text('Feature'),
                        description: const Text(
                          'This feature will be available soon',
                        ),
                      ).show(context);
                    },
                    bgColor: Colors.black,
                    isLoading: false.obs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.apple, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Continue with Apple',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  CustomButton(
                    ontap: () async {
                      CherryToast.info(
                        title: const Text('Feature'),
                        description: const Text(
                          'This feature will be available soon',
                        ),
                      ).show(context);
                    },
                    bgColor: Colors.white,
                    isLoading: false.obs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.instagram),
                        SizedBox(width: 5),
                        Text(
                          'Continue with Instagram',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  CustomButton(
                    ontap: () async {
                      await authController.googleLoginOrSignUp();
                    },
                    isLoading: authController.isGoogleLoading,
                    bgColor: Colors.white,
                    loaderColor: AppColors.primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.google),
                        SizedBox(width: 5),
                        Text(
                          'Continue with Google',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
