import 'package:Vetted/app/controller/location_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/data/models/user_model.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SetLocationScreen extends StatelessWidget {
  SetLocationScreen({super.key});

  final locationModel = Rx<LocationModel?>(null);
  final locationController = Get.find<LocationController>();
  final userController = Get.find<UserController>();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                "What city do you live in?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Obx(() {
                return TextField(
                  controller: addressController,
                  readOnly: true,
                  onTap: () async {
                    locationModel.value =
                        await locationController.useMyCurrentLocation();
                    addressController.text = locationModel.value?.address ?? '';
                  },
                  decoration: InputDecoration(
                    hintText:
                        locationController.isloading.value
                            ? "loading..."
                            : "Click to select your city",
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              CustomButton(
                ontap: () async {
                  if (locationModel.value == null) return;
                  await userController.updateLocation(
                    location: locationModel.value!,
                  );
                },
                isLoading: userController.isloading,
                loaderColor: Colors.white,
                child: Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
