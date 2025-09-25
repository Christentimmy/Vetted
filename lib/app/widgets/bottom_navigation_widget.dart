import 'package:Vetted/app/controller/socket_controller.dart';
import 'package:Vetted/app/modules/app_services/views/background_check_screen.dart';
import 'package:Vetted/app/modules/community/views/community_screen.dart';
import 'package:Vetted/app/modules/home/views/home_screen.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/modules/settings/views/setting_screen.dart';
import 'package:Vetted/screens/message_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingBottomNavigationWidget extends StatefulWidget {
  final int? index;
  const FloatingBottomNavigationWidget({super.key, this.index});

  @override
  State<FloatingBottomNavigationWidget> createState() =>
      _FloatingBottomNavigationWidgetState();
}

class _FloatingBottomNavigationWidgetState
    extends State<FloatingBottomNavigationWidget> {
  final RxInt currentIndex = 0.obs;

  final socketController = Get.find<SocketController>();

  @override
  void initState() {
    super.initState();
    currentIndex.value = widget.index ?? 0;
    if(socketController.socket == null){
      socketController.initializeSocket();
    }
  }

  final List<Widget> items = [
    HomeScreen(),
    CommunityScreen(),
    BackgroundCheckScreen(),
    MessageListScreen(),
    SettingScreen(),
  ];

  final List<BottomNavItem> navItems = [
    BottomNavItem(icon: Icons.home, label: ''),
    BottomNavItem(icon: Icons.group, label: ''),
    BottomNavItem(icon: Icons.work_rounded, label: ''),
    BottomNavItem(icon: Icons.message, label: ''),
    BottomNavItem(icon: Icons.person, label: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          Obx(() => items[currentIndex.value]),

          // Floating Bottom Sheet
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Obx(() => _buildFloatingBottomSheet(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingBottomSheet(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 40,
            offset: const Offset(0, 16),
            spreadRadius: 0,
          ),
        ],
      ),
      child: _buildNavigationBar(),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = currentIndex.value == index;

              return GestureDetector(
                onTap: () {
                  currentIndex.value = index;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      index == 0
                          ? Image.asset(
                            "assets/images/v_logo_2.png",
                            height: 20,
                            fit: BoxFit.cover,
                            color:
                                isSelected
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                          )
                          : Icon(
                            item.icon,
                            color:
                                isSelected
                                    ? AppColors.primaryColor
                                    : Colors.grey[600],
                            size: 24,
                          ),
                      // index == 0
                      //     ? const SizedBox(height: 5)
                      //     : const SizedBox(height: 4),
                      // Text(
                      //   item.label,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color:
                      //         isSelected
                      //             ? AppColors.primaryColor
                      //             : Colors.grey[600],
                      //     fontWeight:
                      //         isSelected ? FontWeight.bold : FontWeight.w400,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String label;

  BottomNavItem({required this.icon, required this.label});
}
