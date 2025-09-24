import 'package:Vetted/app/modules/post/controller/create_post_controller.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // final TextEditingController _controller = TextEditingController();
  // final TextEditingController _titleController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final createPostController = Get.put(CreatePostController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPostingRulesPopup();
    });
  }

  @override
  void dispose() {
    Get.delete<CreatePostController>();
    super.dispose();
  }

  void _showPostingRulesPopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must click Got It
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Posting Rules",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Rules list
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 146, 21, 21)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _RuleItem("No last names"),
                      _RuleItem("No contact information"),
                      _RuleItem("No sensitive personal data"),
                      _RuleItem("No social handles"),
                      _RuleItem("No bullying"),
                      _RuleItem("No harmful content"),
                      _RuleItem("No posting men"),
                      _RuleItem("No posting women under 18"),
                      _RuleItem("All statement must be true"),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                const Text(
                  "Users that violate these rules will be banned.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close popup
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 146, 21, 21),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Got It!",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              const SizedBox(height: 10),

              // Back Arrow & Title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Create post",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                "Anonymous",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: createPostController.titleController,
                        decoration: const InputDecoration(
                          hintText: "Post Title",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a value";
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Post Content field
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        controller: createPostController.textController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: "What’s on your mind?",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a value";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Post Title field
              const SizedBox(height: 24),

              // Image Options
              _buildPostOption("assets/images/icons/woman.png", "Woman", () {
                Get.toNamed(AppRoutes.womanPostScreen);
              }),
              const SizedBox(height: 12),
              _buildPostOption("assets/images/icons/poll.png", "Poll", () {
                Get.toNamed(AppRoutes.pollPostScreen);
              }),

              SizedBox(height: Get.height * 0.15),

              // Post Button
              CustomButton(
                ontap:
                    () => createPostController.createRegularPost(
                      formKey: formKey,
                    ),
                isLoading: createPostController.isLoading,
                loaderColor: Colors.white,
                child: Text(
                  'Post',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostOption(String imagePath, String label, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 30,
      onTap: onTap,
      leading: Image.asset(imagePath, height: 24, width: 24),
      title: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}

class _RuleItem extends StatelessWidget {
  final String text;
  const _RuleItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Color.fromARGB(255, 146, 21, 21),
            size: 10,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
