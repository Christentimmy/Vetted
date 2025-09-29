import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
          Image.asset('assets/images/background_1.png', fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.5)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),

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

                  const SizedBox(height: 24),

                  const Text(
                    'Designed to help men date safely by\nproviding a platform to background check\npotential dates, read reviews, and get advice\nfrom an anonymous community of men',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: Get.height * 0.2),
                  // const Spacer(),

                  // GestureDetector(
                  //   onTap: () {
                  //     Get.toNamed(
                  //       AppRoutes.phoneNumberScreen,
                  //       arguments: {'isSignUp': true},
                  //     );
                  //   },
                  //   child: const Text(
                  //     'Let’s get started',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(height: 16),

                  // _buildWideButton(
                  //   text: 'Log in with phone number',
                  //   color: Colors.red.shade700,
                  //   textColor: Colors.white,
                  //   onPressed: () {
                  //     Get.toNamed(
                  //       AppRoutes.phoneNumberScreen,
                  //       arguments: {'isSignUp': false},
                  //     );
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (context) => const PhoneNumberLoginScreen(),
                  //     //   ),
                  //     // );
                  //   },
                  // ),

                  // const SizedBox(height: 20),

                  // // OR Divider with lines
                  // Row(
                  //   children: const [
                  //     Expanded(
                  //       child: Divider(color: Colors.white54, thickness: 1),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 8),
                  //       child: Text(
                  //         "or",
                  //         style: TextStyle(color: Colors.white70),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Divider(color: Colors.white54, thickness: 1),
                  //     ),
                  //   ],
                  // ),

                  // const SizedBox(height: 20),

                  // Apple Button
                  _buildWideSignInButton(Buttons.AppleDark, onPressed: () {}),

                  const SizedBox(height: 14),

                  // Instagram Button
                  _buildWideIconButton(
                    text: 'Continue with Instagram',
                    icon: FontAwesomeIcons.instagram,
                    color: Colors.white,
                    textColor: Colors.black,
                    iconColor: Colors.purple,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 14),
                  CustomButton(
                    ontap: () async {
                      await authController.googleLoginOrSignUp();
                    },
                    isLoading: authController.isGoogleLoading,
                    bgColor: Colors.white,
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

                  const SizedBox(height: 14),

                  // Google Button
                  // _buildWideSignInButton(
                  //   Buttons.Google,
                  //   onPressed: () async {},
                  // ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Phone/Custom Button
  static Widget buildWideButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  // Google / Apple
  static Widget _buildWideSignInButton(
    Buttons type, {
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: SignInButton(
        type,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 4),
      ),
    );
  }

  // Instagram Custom Icon Button
  static Widget _buildWideIconButton({
    required String text,
    required IconData icon,
    required Color color,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        icon: FaIcon(icon, color: iconColor),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
