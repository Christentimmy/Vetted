import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/staggered_column_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurSafetyToolsScreen extends StatelessWidget {
  const OurSafetyToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_Feature> features = [
      _Feature(
        "assets/images/icons/run_background.png",
        "Run background checks",
      ),
      _Feature(
        "assets/images/icons/check_criminal.png",
        "Check criminal records",
      ),
      _Feature("assets/images/icons/Search_1.png", "Search for sex offenders"),
      _Feature("assets/images/icons/look_up.png", "Look up phone numbers"),
      _Feature("assets/images/icons/search.png", "Reverse image searches"),
      _Feature(
        "assets/images/icons/find_social.png",
        "Find social media profiles",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Text.rich(
              TextSpan(
                text: 'OUR ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'SAFETY ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: 'TOOLS'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            StaggeredColumnAnimation(
              children:
                  features.map((feature) => buildFeature(feature)).toList(),
            ),

            // Feature List
            const Spacer(),

            // Continue Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.allowNotificationScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildFeature(_Feature feature) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(feature.iconPath, width: 28, height: 28),
          title: Text(feature.title, style: const TextStyle(fontSize: 14)),
        ),
        const Divider(height: 1, thickness: 0.8),
      ],
    );
  }
}

class _Feature {
  final String iconPath;
  final String title;

  _Feature(this.iconPath, this.title);
}
