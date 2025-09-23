import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberScreen extends StatelessWidget {
  PhoneNumberScreen({super.key});

  final authController = Get.find<AuthController>();
  final phoneNumberController = TextEditingController();

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

              const Text(
                'What Your Number?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 8),

              const Text(
                "We’ll send you an OTP to verify your identity",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 40),

              IntlPhoneField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Write your number',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: UnderlineInputBorder(),
                ),
                initialCountryCode: 'US',
                // onChanged: (phone) {
                //   setState(() {
                //     phoneNumber = phone.number;
                //     completePhoneNumber = phone.completeNumber;
                //   });
                // },
                flagsButtonMargin: const EdgeInsets.only(right: 8),
                dropdownIconPosition: IconPosition.trailing,
              ),

              const SizedBox(height: 24),

              // Continue Button with loading spinner
              CustomButton(
                ontap: () async {
                  HapticFeedback.lightImpact();
                  if (phoneNumberController.text.isEmpty) return;
                  if (authController.isLoading.value) return;
                  await authController.registerWithNumber(
                    phoneNumber: phoneNumberController.text,
                  );
                },
                loaderColor: Colors.white,
                isLoading: authController.isLoading,
                child: Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text.rich(
                TextSpan(
                  text: 'By continuing you agree to our ',
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
