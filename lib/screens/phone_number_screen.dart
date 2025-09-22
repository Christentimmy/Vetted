import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'otp_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String phoneNumber = '';
  String completePhoneNumber = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isValid = phoneNumber.isNotEmpty;

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
                decoration: const InputDecoration(
                  hintText: 'Write your number',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: UnderlineInputBorder(),
                ),
                initialCountryCode: 'US',
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone.number;
                    completePhoneNumber = phone.completeNumber;
                  });
                },
                flagsButtonMargin: const EdgeInsets.only(right: 8),
                dropdownIconPosition: IconPosition.trailing,
              ),

              const SizedBox(height: 24),

              // Continue Button with loading spinner
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isValid ? Colors.red.shade700 : Colors.red.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:
                      isValid && !isLoading
                          ? () async {
                            setState(() => isLoading = true);

                            // Simulate delay
                            await Future.delayed(const Duration(seconds: 2));

                            setState(() => isLoading = false);

                            // Navigate to OTP screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => OTPScreen(
                                      phoneNumber: completePhoneNumber,
                                    ),
                              ),
                            );
                          }
                          : null,
                  child:
                      isLoading
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                          : const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
