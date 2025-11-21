import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  final VoidCallback? onTap;

  const OTPScreen({super.key, required this.email, this.onTap});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final authController = Get.find<AuthController>();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Image (replace with your asset)
              Image.asset('assets/images/otp_illustration.png', height: 120),

              const SizedBox(height: 32),

              const Text(
                'Verification code',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 8),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                  children: [
                    const TextSpan(
                      text: 'Please enter the 6-digit code sent to\n',
                    ),
                    TextSpan(
                      text: widget.email,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: '  '),
                    // TextSpan(
                    //   text: 'edit',
                    //   style: const TextStyle(
                    //     decoration: TextDecoration.underline,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.blueAccent,
                    //   ),
                    //   recognizer:
                    //       TapGestureRecognizer()
                    //         ..onTap = () {
                    //           Navigator.pop(context); // go back to phone input
                    //         },
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // OTP Input
              PinCodeTextField(
                appContext: context,
                length: 4,
                controller: otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                onCompleted: (v) {
                  // authController.verifyNumberOtp(
                  //   phoneNumber: widget.phoneNumber,
                  //   otp: v,
                  //   whatNext: widget.onTap,
                  // );
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  selectedFillColor: Colors.transparent,
                  inactiveColor: Colors.black26,
                  selectedColor: Colors.black87,
                  activeColor: Colors.black,
                ),
                textStyle: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // Continue Button
              CustomButton(
                ontap: () async {
                  if (otpController.text.isEmpty) return;
                  // await authController.verifyNumberOtp(
                  //   phoneNumber: widget.phoneNumber,
                  //   otp: otpController.text,
                  //   whatNext: widget.onTap,
                  // );
                },
                isLoading: authController.isOtpVerifyLoading,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              // Terms and Privacy
              const Text.rich(
                TextSpan(
                  text: 'By continue you agree our ',
                  style: TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Terms',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
