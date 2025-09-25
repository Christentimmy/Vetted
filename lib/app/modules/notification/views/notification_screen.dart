

import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () => userController.getNotifications(showLoader: false),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              // Header with back icon and title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Go back
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Notification',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 8),
          
              // Notification List
              Obx(() {
                if (userController.isloading.value) {
                  return SizedBox(
                    height: Get.height * 0.55,
                    width: Get.width,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                }
                if (userController.notificationList.isEmpty) {
                  return SizedBox(
                    height: Get.height * 0.55,
                    width: Get.width,
                    child: const Center(child: Text('No notifications')),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userController.notificationList.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = userController.notificationList[index];
                    return ListTile(
                      tileColor:
                          !item.isRead.value
                              ? AppColors.primaryColor.withValues(alpha: 0.2)
                              : Colors.white,
                      onTap: () {
                        item.isRead.value = !item.isRead.value;
                        userController.markNotificationAsRead(id: item.id);
                      },
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.scatter_plot_rounded,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        item.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        DateFormat('hh:mm a').format(item.createdAt),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
