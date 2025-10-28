import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/modules/post/widgets/custom_textfield.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final reasonController = TextEditingController();

  final List<String> _reportReasons = [
    "Spam",
    "Image is fake",
    "Image is not public",
    "Profile is likely fake, spam, or scammer",
    "Inappropriate content",
    "Underage or minor",
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
                      onTap: () {
                        if (index == 7) {
                          enterReasonBottomSheet(context);
                          return;
                        }
                        _reportUser(_reportReasons[index]);
                      },
                      contentPadding: EdgeInsets.zero,
                    );
                  },
                ),
      ),
    );
  }

  Future<dynamic> enterReasonBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,

      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextField(
                controller: reasonController,
                hintText: "Enter reason",
              ),
              const SizedBox(height: 16),
              CustomButton(
                ontap: () {
                  if (reasonController.text.isEmpty) {
                    CustomSnackbar.showErrorToast("Please enter a reason");
                    return;
                  }
                  Get.back();
                  _reportUser(reasonController.text);
                },
                isLoading: false.obs,
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
