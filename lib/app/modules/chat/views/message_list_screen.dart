import 'package:Vetted/app/controller/message_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/screens/add_friends_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  final messageController = Get.find<MessageController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!messageController.isChattedListFetched.value) {
        messageController.getChatList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Obx(() {
        if (messageController.isChatListLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        if (messageController.allChattedUserList.isEmpty) {
          return const Center(child: Text("No Chatted User"));
        }
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: ()=> messageController.getChatList(showLoading: false),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: messageController.allChattedUserList.length,
            itemBuilder: (context, index) {
              final msg = messageController.allChattedUserList[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.chatScreen, arguments: {'chatHead': msg});
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.displayName ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              msg.lastMessage ?? "",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        msg.unreadCount.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Messages',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          color: Colors.black,
          onPressed: () {
            // ✅ Navigate to AddFriendsScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddFriendsScreen()),
            );
          },
        ),
      ],
      elevation: 0.5,
      backgroundColor: Colors.white,
    );
  }
}
