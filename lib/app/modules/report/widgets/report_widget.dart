
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportType {
  static const post = ReportType._('post');
  static const profile = ReportType._('profile');
  static const story = ReportType._('story');
  static const message = ReportType._('message');
  static const group = ReportType._('group');
  static const other = ReportType._('other');

  final String value;

  const ReportType._(this.value);

  @override
  String toString() => value;
}

class ReportBottomSheet extends StatefulWidget {
  final String reportUser;
  final ReportType type;
  final String? referenceId;
  const ReportBottomSheet({
    super.key,
    required this.reportUser,
    required this.type,
    this.referenceId,
  });

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  final _userController = Get.find<UserController>();
  RxBool isLoading = false.obs;

  final List<String> _reportReasons = [
    "No reason",
    "I'm not interested in this person",
    "Profile isDisliking fake, spam, or scammer",
    "Inappropriate content",
    "Underage or minor",
    "Off-Hinge behavior",
    "Someone is in danger",
    "Other",
  ];

  void _reportUser(String reason) async {
    await _userController.reportUser(
      type: widget.type.value,
      reason: reason,
      reportedUser: widget.reportUser,
      referenceId: widget.referenceId ?? "",
    );
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Obx(
        () =>
            isLoading.value
                ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
                : ListView.builder(
                  itemCount: _reportReasons.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _reportReasons[index],
                        style: Get.textTheme.bodyMedium,
                      ),
                      onTap: () => _reportUser(_reportReasons[index]),
                      contentPadding: EdgeInsets.zero,
                    );
                  },
                ),
      ),
    );
  }
}
