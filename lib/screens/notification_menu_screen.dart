import 'package:Vetted/app/controller/user_controller.dart';
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
  bool alertMensNames = false;
  bool reactions = true;

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
      body: Padding(
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
            _buildSwitchTile("Alert for Women’s Names", alertMensNames, (val) {
              setState(() => alertMensNames = val);
            }),
            _buildSwitchTile("Reactions", reactions, (val) {
              setState(() => reactions = val);
            }),
          ],
        ),
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
