import 'package:flutter/material.dart';
import 'notification_screen.dart';
import 'home_screen.dart';
import 'background_check_screen.dart';
import 'community_screen.dart';
import 'account_details_screen.dart';
import 'upgrade_plan_screen.dart';
import 'welcome_screen.dart';
import 'my_post_screen.dart';
import 'saved_post_screen.dart';
import 'my_alerts_screen.dart';
import 'safety_resources_screen.dart';
import 'support_screen.dart';
import 'notification_menu_screen.dart';

class MenuPageScreen extends StatelessWidget {
  const MenuPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // 🔹 Header Row
            Row(
              children: [
                Image.asset('assets/images/logo_black.png', height: 28),
                const SizedBox(width: 8),
                const Text(
                  "Vetted",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Container(
                  height: 36,
                  width: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showFilterPopup(context),
                        child: const Icon(
                          Icons.filter_list,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.notifications_none),
                ),
              ],
            ),

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AccountDetailsScreen(),
                  ),
                );
              },
            ),
            _menuItem(
              icon: Icons.edit_note_outlined,
              title: "My Post",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyPostScreen()),
                );
              },
            ),
            _menuItem(
              icon: Icons.bookmark_border,
              title: "Saved Post",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SavedPostScreen()),
                );
              },
            ),
            _menuItem(
              icon: Icons.warning_amber_outlined,
              title: "My Alerts",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyAlertsScreen()),
                );
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

            const SizedBox(height: 24),
            const Text(
              "Settings",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _menuItem(icon: Icons.face_unlock_outlined, title: "Face ID"),
            _menuItem(
              icon: Icons.help_outline,
              title: "Frequently Asked Questions",
            ),
            _menuItem(
              icon: Icons.support_agent_outlined,
              title: "Support",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SupportScreen()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UpgradePlanScreen()),
                );
              },
            ),

            const SizedBox(height: 24),
            _menuItem(title: "Terms of use", isBold: true),
            _menuItem(title: "Privacy policy", isBold: true),

            const SizedBox(height: 16),
            _menuItem(
              icon: Icons.logout,
              title: "Logout",
              color: Colors.black,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  (route) => false, // Removes all previous routes
                );
              },
            ),
          ],
        ),
      ),

      // 🔻 Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Home
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                child: Image.asset(
                  'assets/images/icons/nav_inactive4.png',
                  height: 24,
                ),
              ),
              // Background Check
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BackgroundCheckScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/icons/nav_inactive1.png',
                  height: 24,
                ),
              ),
              // Community
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const CommunityScreen()),
                  );
                },
                child: Image.asset(
                  'assets/images/icons/nav_inactive2.png',
                  height: 24,
                ),
              ),
              // Current Screen
              Image.asset('assets/images/icons/nav_active3.png', height: 40),
            ],
          ),
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
        style: TextStyle(
          color: color,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showFilterPopup(BuildContext context) {
    String sortBy = 'newest';
    bool showRedFlag = true;
    bool showGreenFlag = true;
    double maxDistance = 1500;
    RangeValues ageRange = const RangeValues(18, 75);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 36,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Filter posts",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Anonymous", style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Maximum distance",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Slider(
                      value: maxDistance,
                      min: 0,
                      max: 1500,
                      divisions: 30,
                      label: "${maxDistance.round()}+ mi",
                      onChanged: (value) {
                        setState(() => maxDistance = value);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${maxDistance.round()}+ mi",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Age range",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    RangeSlider(
                      values: ageRange,
                      min: 18,
                      max: 75,
                      divisions: 57,
                      labels: RangeLabels(
                        "${ageRange.start.round()}",
                        "${ageRange.end.round()}",
                      ),
                      onChanged: (values) {
                        setState(() => ageRange = values);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "From ${ageRange.start.round()} to ${ageRange.end.round()}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sort by",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'newest',
                          groupValue: sortBy,
                          onChanged: (value) => setState(() => sortBy = value!),
                        ),
                        const Text('Newest'),
                        Radio<String>(
                          value: 'oldest',
                          groupValue: sortBy,
                          onChanged: (value) => setState(() => sortBy = value!),
                        ),
                        const Text('Oldest'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap:
                                () =>
                                    setState(() => showRedFlag = !showRedFlag),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  const Text("Post has"),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.flag,
                                        size: 20,
                                        color:
                                            showRedFlag
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                      const SizedBox(width: 6),
                                      Icon(
                                        Icons.flag,
                                        size: 20,
                                        color:
                                            showRedFlag
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap:
                                () => setState(
                                  () => showGreenFlag = !showGreenFlag,
                                ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  const Text("Post has"),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.flag,
                                        size: 20,
                                        color:
                                            showGreenFlag
                                                ? Colors.green
                                                : Colors.grey,
                                      ),
                                      const SizedBox(width: 6),
                                      Icon(
                                        Icons.flag,
                                        size: 20,
                                        color:
                                            showGreenFlag
                                                ? Colors.green
                                                : Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
