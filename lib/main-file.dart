import 'package:flutter/material.dart';
import 'screens/otp_screen.dart'; // ✅ Make sure this file exists

void main() {
  runApp(const VettedApp());
}

class VettedApp extends StatelessWidget {
  const VettedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vetted',
      debugShowCheckedModeBanner: false,
      // 👇 Directly show OTP screen for now
      home: OTPScreen(phoneNumber: '+1 331 623 8413'),
    );
  }
}
