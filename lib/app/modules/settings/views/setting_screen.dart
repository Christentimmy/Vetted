import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              icon: FontAwesomeIcons.userGroup,
              iconSize: 15,
              title: "Invite Friends",
              onTap: () {
                final userController = Get.find<UserController>();
                final userModel = userController.userModel.value;
                if (userModel == null) return;
                if (userModel.inviteCode?.isEmpty == true) {
                  Get.toNamed(AppRoutes.inviteScreen);
                } else {
                  Get.toNamed(AppRoutes.inviteStatsScreen);
                }
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
                Get.toNamed(AppRoutes.myAlertsScreen);
              },
            ),
            _menuItem(
              icon: Icons.shield_outlined,
              title: "Safety Resources",
              onTap: () {
                Get.toNamed(AppRoutes.safetyResourcesScreen);
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
                Get.toNamed(AppRoutes.supportScreen);
              },
            ),
            _menuItem(
              icon: Icons.notifications_outlined,
              title: "Notifications",
              onTap: () {
                Get.toNamed(AppRoutes.notificationMenuScreen);
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
            _menuItem(
              title: "Terms of use",
              isBold: true,
              onTap: () {
                Get.toNamed(
                  AppRoutes.termsAndConditionScreen,
                  arguments: {"justAScreen": true},
                );
              },
            ),

            // _menuItem(title: "Privacy policy", isBold: true),
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
    double? iconSize,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading:
          icon != null ? Icon(icon, size: iconSize ?? 22, color: color) : null,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }
}
