import 'package:Vetted/app/controller/location_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/data/models/user_model.dart';
import 'package:Vetted/app/modules/post/widgets/custom_textfield.dart';
// import 'package:Vetted/app/resources/colors.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final userController = Get.find<UserController>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final locationModel = Rx<LocationModel?>(null);
  final locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    nameController.text = userController.userModel.value?.displayName ?? '';
    emailController.text = userController.userModel.value?.email ?? '';
    phoneController.text = userController.userModel.value?.phone ?? '';
    addressController.text =
        userController.userModel.value?.location?.address ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Account',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          children: [
            CustomTextField(
              controller: nameController,
              hintText: 'Display Name',
              bgColor: Colors.grey.shade200,
              enabledBorderColor: Colors.grey.shade300,
            ),

            // _textInputField(label: 'Anonymous'),
            const SizedBox(height: 12),

            // Email
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
              bgColor: Colors.grey.shade200,
              enabledBorderColor: Colors.grey.shade300,
            ),

            const SizedBox(height: 12),

            // Phone Number
            CustomTextField(
              controller: phoneController,
              hintText: 'Phone number',
              bgColor: Colors.grey.shade200,
              enabledBorderColor: Colors.grey.shade300,
              keyboardType: TextInputType.phone,
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 12),

            // Location Dropdown
            // _dropdownField(cities, selectedCity),
            CustomTextField(
              controller: addressController,
              hintText: 'Location',
              readOnly: true,
              bgColor: Colors.grey.shade200,
              enabledBorderColor: Colors.grey.shade300,
              keyboardType: TextInputType.phone,
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              // suffixIcon: FontAwesomeIcons.solidPenToSquare,
              // suffixIconcolor: AppColors.primaryColor,
              // onSuffixTap: () async {
                // locationModel.value =
                //     await locationController.useMyCurrentLocation();
                // addressController.text = locationModel.value?.address ?? '';
              // },
            ),

            const SizedBox(height: 12),

            CustomTextField(
              controller: TextEditingController(),
              hintText:
                  userController.userModel.value!.dateOfBirth != null
                      ? DateFormat(
                        'dd/MM/yyyy',
                      ).format(userController.userModel.value!.dateOfBirth!)
                      : 'Date of Birth',
              bgColor: Colors.grey.shade200,
              enabledBorderColor: Colors.grey.shade300,
              readOnly: true,
              keyboardType: TextInputType.phone,
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final userModel = UserModel(
                    displayName: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    location: LocationModel(
                      address: addressController.text,
                      coordinates: locationModel.value?.coordinates,
                    ),
                  );
                  await userController.editProfile(userModel: userModel);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Obx(() {
                  if (userController.isloading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),

            // Delete Account
            // TextButton(
            //   onPressed: () {
            //     // Delete account logic
            //   },
            //   child: const Text(
            //     'Delete account',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
