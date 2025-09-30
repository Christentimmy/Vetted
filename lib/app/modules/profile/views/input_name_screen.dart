import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/staggered_column_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InputNameScreen extends StatelessWidget {
  final VoidCallback? whatNext;
  InputNameScreen({super.key, this.whatNext});

  final userController = Get.find<UserController>();
  final _nameController = TextEditingController();
  final formKey = GlobalKey<FormState>().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: StaggeredColumnAnimation(
            duration: Duration(milliseconds: 400),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/images/icons/name_popup.png', height: 80),
              const SizedBox(height: 32),
              const Text(
                "What’s your Name?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                "Enter Anonymous Screen Name",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              Form(
                key: formKey.value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.startsWith(' ')) {
                      return 'Name cannot start with a space';
                    }
                    if (value.split(' ').length < 2) {
                      return 'Full Name Required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Full name",
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                ontap: updateName,
                isLoading: userController.isloading,
                loaderColor: Colors.white,
                child: Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text.rich(
                TextSpan(
                  text: 'By continue you agree our ',
                  style: TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Terms',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateName() {
    HapticFeedback.lightImpact();
    if (!formKey.value.currentState!.validate()) return;
    userController.updateName(name: _nameController.text, whatNext: whatNext);
  }
}
