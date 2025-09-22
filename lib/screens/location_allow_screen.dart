import 'package:flutter/material.dart';
import 'selfie_verification_screen.dart';

class LocationAllowScreen extends StatelessWidget {
  const LocationAllowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Column(
                  children: [
                    Text(
                      "Allow Vetted to use\nyour location",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "We will use your location to find people\nnearby you.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),

              // Map Image Placeholder
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                child: Image.asset(
                  'assets/images/map_mock.png', // Replace with your actual image
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Buttons
              Column(
                children: [
                  _buildOptionButton("Allow Once", context),
                  _buildOptionButton("Allow while using the app", context),
                  _buildOptionButton("Don’t Allow", context, isLast: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
    String text,
    BuildContext context, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          title: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          onTap: () {
            // Navigate to the SelfieVerificationScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelfieVerificationScreen(),
              ),
            );
          },
        ),
        if (!isLast)
          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
      ],
    );
  }
}
