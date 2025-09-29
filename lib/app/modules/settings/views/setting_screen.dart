import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/top_bar.dart';
// import 'package:Vetted/screens/my_alerts_screen.dart';
// import 'package:Vetted/screens/my_post_screen.dart';
import 'package:Vetted/screens/notification_menu_screen.dart';
import 'package:Vetted/screens/safety_resources_screen.dart';
// import 'package:Vetted/screens/saved_post_screen.dart';
// import 'package:Vetted/screens/upgrade_plan_screen.dart';
// import 'package:Vetted/screens/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // 🔹 Header Row
            buildTopBar(context),
            const SizedBox(height: 24),

            const Text(
              "Profile",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 16),
            _menuItem(
              icon: Icons.person_outline,
              title: "Account",
              onTap: () {
                Get.toNamed(AppRoutes.editProfileScreen);
              },
            ),
            _menuItem(
              icon: Icons.edit_note_outlined,
              title: "My Post",
              onTap: () {
                Get.toNamed(AppRoutes.myPostScreen);
              },
            ),
            _menuItem(
              icon: Icons.bookmark_border,
              title: "Saved Post",
              onTap: () {
                Get.toNamed(AppRoutes.savedPostScreen);
              },
            ),
            _menuItem(
              icon: Icons.warning_amber_outlined,
              title: "My Alerts",
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => const MyAlertsScreen()),
                // );
                Get.toNamed(AppRoutes.myAlertsScreen);
              },
            ),
            _menuItem(
              icon: Icons.shield_outlined,
              title: "Safety Resources",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SafetyResourcesScreen(),
                  ),
                );
              },
            ),
            _menuItem(
              icon: Icons.insert_chart_outlined_rounded,
              title: "Court Resources",
              onTap: () {
                Get.toNamed(AppRoutes.courtStateResources);
              },
            ),

            const SizedBox(height: 24),
            const Text(
              "Settings",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            // _menuItem(icon: Icons.face_unlock_outlined, title: "Face ID"),
            _menuItem(
              icon: Icons.help_outline,
              title: "Frequently Asked Questions",
              onTap: () {
                Get.toNamed(AppRoutes.faqScreen);
              },
            ),
            _menuItem(
              icon: Icons.support_agent_outlined,
              title: "Support",
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => const SupportScreen()),
                // );
                Get.toNamed(AppRoutes.supportScreen);
              },
            ),
            _menuItem(
              icon: Icons.notifications_outlined,
              title: "Notifications",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationMenuScreen(),
                  ),
                );
              },
            ),
            _menuItem(
              icon: Icons.workspace_premium_outlined,
              title: "Upgrade",
              onTap: () {
                Get.toNamed(AppRoutes.upgradePlanScreen);
              },
            ),

            const SizedBox(height: 24),
            _menuItem(title: "Terms of use", isBold: true),
            _menuItem(title: "Privacy policy", isBold: true),

            const SizedBox(height: 16),
            _menuItem(
              icon: Icons.logout,
              title: "Logout",
              color: Colors.red,
              onTap: () async {
                Get.offAllNamed(AppRoutes.onboardingScreen);
                Get.find<AuthController>().logout();
              },
            ),
            SizedBox(height: Get.height * 0.1),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    IconData? icon,
    required String title,
    bool isBold = false,
    Color color = Colors.black54,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: icon != null ? Icon(icon, size: 22, color: color) : null,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }
}
