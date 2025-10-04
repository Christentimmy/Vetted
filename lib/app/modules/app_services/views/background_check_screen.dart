import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/utils/image_picker.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:Vetted/app/widgets/top_bar.dart';
import 'package:Vetted/screens/criminal_record_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundCheckScreen extends StatelessWidget {
  BackgroundCheckScreen({super.key});

  final appServiceController = Get.find<AppServiceController>();

  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 12),
            buildTopBar(context),
            const SizedBox(height: 24),

            Text(
              "Check Phone Number",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                      cursorColor: AppColors.primaryColor,

                      decoration: InputDecoration(
                        hintText: "(353) 745-8736",
                        hintStyle: GoogleFonts.fredoka(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (phoneNumberController.text.isEmpty) {
                        CustomSnackbar.showErrorToast(
                          "Please enter a phone number",
                        );
                        return;
                      }
                      await appServiceController.getNumberInfo(
                        number: phoneNumberController.text,
                      );
                      // phoneNumberController.clear();
                    },
                    child: Obx(
                      () =>
                          appServiceController.isloading.value
                              ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                              : Text(
                                "Search",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              "Sex Offenders Map",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.sexOffendersMapScreen),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryColor.withValues(alpha: 0.3),
                      BlendMode.darken,
                    ),
                    image: AssetImage('assets/images/map_sample.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              "Reverse Image Search",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Find her social media profiles",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 12),

            // 🔗 Navigate to ReverseImageScreen
            GestureDetector(
              onTap: () async {
                HapticFeedback.lightImpact();
                final im = await pickImage();
                if (im == null) return;
                appServiceController.reverseImageSearch(file: im);
              },
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Center(
                  child: Obx(() {
                    if (appServiceController.isloadingImage.value) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image,
                          size: 60,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Choose Photo",
                          style: GoogleFonts.fredoka(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ✅ Linked Buttons
            _customButton(
              "Background Check",
              "Get Started",
              AppColors.primaryColor,
              () => Get.toNamed(AppRoutes.backgroundCheckSearchScreen),
            ),
            _customButton(
              "Criminal Record Search",
              "Search Now",
              AppColors.primaryColor,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CriminalRecordSearchScreen(),
                  ),
                );
              },
            ),
            _customButton(
              "Court Search Resources",
              "View Resources",
              AppColors.primaryColor,
              () {
                Get.toNamed(AppRoutes.courtStateResources);
              },
            ),
            SizedBox(height: Get.height * 0.12),
          ],
        ),
      ),
    );
  }

  // Updated to accept onTap
  Widget _customButton(
    String title,
    String actionText,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(title, style: GoogleFonts.fredoka(fontSize: 16)),
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(
                actionText,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
