
import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/modules/post/widgets/custom_textfield.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  ResetPasswordScreen({super.key, required this.email});


  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          SizedBox(height: Get.height * 0.1),
          Center(
            child: Text(
              "Reset Password",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.1),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Password",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                CustomTextField(
                  controller: newPasswordController,
                  bgColor: Color.fromARGB(255, 243, 243, 243),
                ),
                SizedBox(height: 15),
                Text(
                  "Confirm Password",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 10),

                CustomTextField(
                  controller: confirmNewPasswordController,
                  bgColor: Color.fromARGB(255, 243, 243, 243),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value != newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.15),
          CustomButton(
            ontap: () async {
              if (!formKey.currentState!.validate()) return;
              await authController.resetPassword(
                email: email,
                password: newPasswordController.text,
              );
            },
            isLoading: authController.isLoading,
            child: Text(
              "Reset",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
