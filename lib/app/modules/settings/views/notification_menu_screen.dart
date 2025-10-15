import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationMenuScreen extends StatefulWidget {
  const NotificationMenuScreen({super.key});

  @override
  State<NotificationMenuScreen> createState() => _NotificationMenuScreenState();
}

class _NotificationMenuScreenState extends State<NotificationMenuScreen> {
  final userController = Get.find<UserController>();

  // toggle states
  bool general = true;
  bool trendingPost = true;
  bool newComments = true;
  bool alertForWomenNames = false;
  bool reactions = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async  {
      await userController.getUserDetails();
      final user = userController.userModel.value;
      if (user == null) return;
      general = user.notificationSettings?.general ?? false;
      trendingPost = user.notificationSettings?.trendingPost ?? false;
      newComments = user.notificationSettings?.newComments ?? false;
      alertForWomenNames =
          user.notificationSettings?.alertForWomenNames ?? false;
      reactions = user.notificationSettings?.reactions ?? false;
      setState(() {});  
    });
  }

  @override
  void dispose() {
    userController.changeNotificationSetting(
      general: general,
      trendingPost: trendingPost,
      newComments: newComments,
      alertForWomenNames: alertForWomenNames,
      reactions: reactions,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Obx(() {
        if (userController.isloading.value) {
          return const Center(child: Loader2());
        }
        return buildContent();
      }),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Question text
          const Center(
            child: Text(
              "Which notifications would you like to receive?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          // List of toggles
          _buildSwitchTile("General", general, (val) {
            setState(() => general = val);
          }),
          _buildSwitchTile("Trending Post", trendingPost, (val) {
            setState(() => trendingPost = val);
          }),
          _buildSwitchTile("New Comments", newComments, (val) {
            setState(() => newComments = val);
          }),
          _buildSwitchTile("Alert for Women’s Names", alertForWomenNames, (
            val,
          ) {
            setState(() => alertForWomenNames = val);
          }),
          _buildSwitchTile("Reactions", reactions, (val) {
            setState(() => reactions = val);
          }),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Switch(value: value, onChanged: onChanged, activeColor: Colors.green),
        ],
      ),
    );
  }
}
