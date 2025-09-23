import 'package:Vetted/screens/how_it_work_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/gestures.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback? onTap;

  const OTPScreen({super.key, required this.phoneNumber, this.onTap});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otpCode = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isOtpFilled = otpCode.length == 5;

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
                      text: widget.phoneNumber,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: '  '),
                    TextSpan(
                      text: 'edit',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context); // go back to phone input
                            },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // OTP Input
              PinCodeTextField(
                appContext: context,
                length: 5,
                onChanged: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  activeFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  selectedFillColor: Colors.transparent,
                  inactiveColor: Colors.black26,
                  selectedColor: Colors.black87,
                  activeColor: Colors.black,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        (isOtpFilled && !_isLoading)
                            ? Colors.red.shade700
                            : Colors.red.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onPressed:
                      isOtpFilled
                          ? () async {
                            setState(() {
                              _isLoading = true;
                            });

                            // Simulate API/OTP verification delay
                            await Future.delayed(const Duration(seconds: 2));

                            setState(() {
                              _isLoading = false;
                            });

                            if (widget.onTap != null) {
                              widget.onTap!();
                              return;
                            }

                            // Navigate to How It Works screen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HowItWorksScreen(),
                              ),
                            );

                            // Navigate to next screen or show success
                            print('Verifying OTP: $otpCode');
                          }
                          : null,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isLoading)
                        Container(
                          width: 18,
                          height: 18,
                          margin: const EdgeInsets.only(right: 12),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

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
