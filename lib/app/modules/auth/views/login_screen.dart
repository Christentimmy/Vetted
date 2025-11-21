import 'package:Vetted/app/modules/post/widgets/custom_textfield.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              "Login Your Account",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Center(
            child: Text(
              "Login your vetted account using your email address",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.1),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Forgot Password?",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * 0.15),
          CustomButton(
            ontap: () {
              Get.toNamed(AppRoutes.otp, arguments: {"email": "Timmy"});
            },
            isLoading: false.obs,
            child: Text(
              "Login",
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
              Text("Don't have an account? ", style: GoogleFonts.poppins()),
              Text(
                "Create Account",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
