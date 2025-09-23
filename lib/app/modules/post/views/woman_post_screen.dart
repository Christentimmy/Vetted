import 'package:Vetted/app/modules/post/controller/create_post_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WomanPostScreen extends StatefulWidget {
  const WomanPostScreen({super.key});

  @override
  State<WomanPostScreen> createState() => _WomanPostScreenState();
}

class _WomanPostScreenState extends State<WomanPostScreen> {
  final RxBool _isChecked = false.obs;
  final formKey = GlobalKey<FormState>();
  final createPostController = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),
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

            // First name
            _buildTextField(
              controller: createPostController.firstNameController,
              hint: "First name",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a value";
                }
                if (value.split(" ").length > 1) {
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
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
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

            // Checkbox
            Row(
              children: [
                Obx(() {
                  return Checkbox(
                    activeColor: AppColors.primaryColor,
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _isChecked.value,
                    onChanged: (val) {
                      _isChecked.value = val ?? false;
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

            // Add photo
            GestureDetector(
              onTap: () {
                // Upload image logic here
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

            const SizedBox(height: 20),

            // Preview button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Preview action
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 146, 21, 21),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Preview",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 146, 21, 21),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Post button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Post action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 146, 21, 21),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Post",
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
