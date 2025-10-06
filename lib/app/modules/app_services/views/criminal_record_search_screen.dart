import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CriminalRecordSearchScreen extends StatelessWidget {
  CriminalRecordSearchScreen({super.key});

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final appServiceController = Get.find<AppServiceController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Check out more of her info.",
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            /// First Name
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First name is required';
                      }
                      return null;
                    },
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// Middle Name (optional)
                  TextFormField(
                    controller: _middleNameController,
                    decoration: InputDecoration(
                      hintText: "Middle Name (optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// Last Name
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Last name is required';
                      }
                      return null;
                    },
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            /// Start Check Button
            CustomButton(
              ontap: () async {
                if (!formKey.currentState!.validate()) return;
                await appServiceController.getCriminalRecords(
                  firstName: _firstNameController.text.trim(),
                  middleName: _middleNameController.text.trim(),
                  lastName: _lastNameController.text.trim(),
                );
              },
              isLoading: appServiceController.isloading,
              child: Text(
                "Start Check",
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
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
      title: const Text("Criminal Record Search"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
    );
  }
}
