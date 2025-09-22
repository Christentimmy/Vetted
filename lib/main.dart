import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

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
      home: const WelcomeScreen(),
    );
  }
}
