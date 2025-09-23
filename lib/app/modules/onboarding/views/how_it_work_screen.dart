
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HowItWorksScreen extends StatefulWidget {
  const HowItWorksScreen({super.key});

  @override
  State<HowItWorksScreen> createState() => _HowItWorksScreenState();
}

class _HowItWorksScreenState extends State<HowItWorksScreen> {

  final List<_Feature> features = [
    _Feature("assets/images/icons/anonymous.png", "Everything is anonymous"),
    _Feature("assets/images/icons/screenshot.png", "Screenshots are disabled"),
    _Feature("assets/images/icons/verified.png", "All men are verified"),
    _Feature(
      "assets/images/icons/posts.png",
      "Access all posts across the whole nation",
    ),
    _Feature(
      "assets/images/icons/search.png",
      "Search a woman’s name to know more",
    ),
    _Feature(
      "assets/images/icons/alerts.png",
      "Set an alerts for a woman’s name",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Text.rich(
              TextSpan(
                text: 'HOW ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'VETTED ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: 'WORKS'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Feature List
            ...features.map(
              (feature) => Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      feature.iconPath,
                      width: 28,
                      height: 28,
                    ),
                    title: Text(
                      feature.title,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const Divider(height: 1, thickness: 0.8),
                ],
              ),
            ),

            const Spacer(),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CustomButton(
                ontap: () => Get.toNamed(AppRoutes.ourSafetyToolsScreen),
                isLoading: false.obs,
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Feature {
  final String iconPath;
  final String title;

  _Feature(this.iconPath, this.title);
}
