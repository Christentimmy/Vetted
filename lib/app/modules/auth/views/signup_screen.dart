import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/modules/post/widgets/custom_textfield.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isCheck = false.obs;
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
              "Register Your Account",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: Text(
              "Register an account with vetted today using your Email address",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
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
                  "Email Address",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                CustomTextField(
                  controller: emailController,
                  bgColor: Color.fromARGB(255, 243, 243, 243),
                ),
                SizedBox(height: 15),
                Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                CustomTextField(
                  controller: passwordController,
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
                  controller: confirmPasswordController,
                  bgColor: Color.fromARGB(255, 243, 243, 243),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: isCheck.value,
                  onChanged: (value) => isCheck.value = value!,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  activeColor: AppColors.primaryColor,
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      TextSpan(
                        text: "By clicking the box, you have agree to the ",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: "Terms and Conditions",
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap =
                                  () => Get.toNamed(
                                    AppRoutes.termsAndConditionScreen,
                                  ),
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: " and ",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap =
                                  () => Get.toNamed(AppRoutes.privacyPolicy),
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.15),
          CustomButton(
            ontap: () async {
              if (!formKey.currentState!.validate()) return;
              if (!isCheck.value) {
                CustomSnackbar.showErrorToast(
                  "Please accept the terms and conditions",
                );
                return;
              }
              // Get.toNamed(AppRoutes.otp, arguments: {"email": "Timmy"});
              await authController.registerUser(
                email: emailController.text,
                password: passwordController.text,
              );
            },
            isLoading: authController.isLoading,
            child: Text(
              "Create Account",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? ", style: GoogleFonts.poppins()),
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.loginScreen),
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
