import 'package:Vetted/app/modules/post/controller/create_post_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PollPostScreen extends StatefulWidget {
  const PollPostScreen({super.key});

  @override
  State<PollPostScreen> createState() => _PollPostScreenState();
}

class _PollPostScreenState extends State<PollPostScreen> {
  final createPostController = Get.put(CreatePostController());

  @override
  void dispose() {
    Get.delete<CreatePostController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Post a poll",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // Content
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: createPostController.textController,
                maxLines: 4,
                cursorColor: AppColors.primaryColor,
                decoration: const InputDecoration(
                  hintText: "What’s on your mind?",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Poll Section
            const Text(
              "Options",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),

            Obx(
              () => Column(
                children: List.generate(
                  createPostController.options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                      controller: createPostController.options[index],
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        hintText: "Option ${index + 1}",
                        suffixIcon: IconButton(
                          onPressed:
                              () => createPostController.removeOption(index),
                          icon: Icon(Icons.cancel),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Add option button
            GestureDetector(
              onTap: () => createPostController.addOption(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Add another option",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),

            SizedBox(height: Get.height * 0.15),

            // Post Button
            CustomButton(
              ontap: () => createPostController.createPollPost(),
              isLoading: createPostController.isLoading,
              loaderColor: Colors.white,
              child: Text(
                "Post",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Create post",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
