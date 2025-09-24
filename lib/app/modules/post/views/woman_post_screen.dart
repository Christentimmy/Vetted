import 'package:Vetted/app/modules/post/controller/create_post_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WomanPostScreen extends StatelessWidget {
  WomanPostScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final createPostController = Get.put(CreatePostController());

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
              "Post a woman",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            buildFormFields(),
            Row(
              children: [
                Obx(() {
                  return Checkbox(
                    activeColor: AppColors.primaryColor,
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: createPostController.isChecked.value,
                    onChanged: (val) {
                      createPostController.isChecked.value = val ?? false;
                    },
                  );
                }),
                Expanded(
                  child: Text(
                    "All statements are true, no last names.",
                    style: GoogleFonts.poppins(color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    createPostController.selectImages();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.add, size: 32, color: Colors.black45),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Obx(() {
                  if (createPostController.images.isEmpty) {
                    return Container();
                  }
                  return Expanded(
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: createPostController.images.length,
                        itemBuilder: (context, index) {
                          final file = createPostController.images[index];
                          return InkWell(
                            onTap: () {
                              Get.dialog(Image.file(file));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: Image.file(
                                      file,
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black.withValues(
                                        alpha: 0.7,
                                      ),
                                      radius: 12,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                        onPressed: () {
                                          createPostController.removeImage(
                                            index,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Post button
            CustomButton(
              ontap: () => createPostController.createPost(formKey: formKey),
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

  Form buildFormFields() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First name
          _buildTextField(
            controller: createPostController.firstNameController,
            hint: "First name",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please enter a value";
              }
              final parts = value.trim().split(RegExp(r"\s+"));
              if (parts.length > 1) {
                return "Please enter only first name";
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          // City dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: Obx(() {
                final value = createPostController.selectedCity.value;
                return DropdownButton<String>(
                  hint: const Text("City"),
                  value: value.isEmpty ? null : value,
                  isExpanded: true,
                  items:
                      createPostController.states.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                  onChanged: (value) {
                    createPostController.selectedCity.value = value!;
                  },
                );
              }),
            ),
          ),

          const SizedBox(height: 12),

          // His age
          _buildTextField(
            controller: createPostController.ageController,
            hint: "Her age",
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 12),

          // Caption (optional)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: createPostController.captionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Caption (Optional)",
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        cursorColor: AppColors.primaryColor,
        validator:
            validator ??
            (value) {
              if (value!.isEmpty) {
                return "Please enter a value";
              }
              return null;
            },
        controller: controller,
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }
}
