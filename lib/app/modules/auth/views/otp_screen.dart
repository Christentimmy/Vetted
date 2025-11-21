import 'dart:async';

import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pinput/pinput.dart';

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
  final RxInt resendOtpTimer = 60.obs;

  @override
  void initState() {
    super.initState();
    startResendOtpTimer();
  }

  void startResendOtpTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendOtpTimer.value > 0) {
        resendOtpTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.1),

              Center(
                child: Text(
                  'Confirm OTP',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Center(
                child: Text(
                  "Enter the 6 digit otp that was sent to your Email",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // OTP Input
              Center(
                child: Pinput(
                  length: 6,
                  controller: otpController,
                  onCompleted: (value) async {},
                  defaultPinTheme: PinTheme(
                    width: 65,
                    height: 65,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromRGBO(54, 69, 79, 0.26),
                      ),
                    ),
                  ),
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
              SizedBox(height: 24),
              // Terms and Privacy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn’t receive OTP? "),
                  Obx(
                    () => InkWell(
                      onTap: () async {
                        if (resendOtpTimer.value > 0) return;
                        // await authController.resendOtp(widget.phoneNumber);
                      },
                      child: Text(
                        resendOtpTimer.value > 0 ? "${resendOtpTimer.value}s" : "Resend",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
