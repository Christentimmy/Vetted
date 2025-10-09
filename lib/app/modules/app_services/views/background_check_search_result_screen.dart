import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundCheckSearchResultScreen extends StatefulWidget {
  final String name;
  const BackgroundCheckSearchResultScreen({super.key, required this.name});

  @override
  State<BackgroundCheckSearchResultScreen> createState() =>
      _BackgroundCheckSearchResultScreenState();
}

class _BackgroundCheckSearchResultScreenState
    extends State<BackgroundCheckSearchResultScreen> {

  final appServiceController = Get.find<AppServiceController>();


  @override
  void dispose() {
    appServiceController.personsBackground.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Text(
              widget.name,
              style: GoogleFonts.fredoka(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            color: Colors.red.shade700,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                "We found ${appServiceController.personsBackground.length} matches",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appServiceController.personsBackground.length,
              itemBuilder: (context, index) {
                final person = appServiceController.personsBackground[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.2),
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      person.name,
                      style: GoogleFonts.fredoka(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      person.currentAddresses,
                      style: GoogleFonts.fredoka(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      final Map<String, dynamic> arguments = {
                        "person": person,
                      };
                      Get.toNamed(
                        AppRoutes.backgroundResultMoreDetailsDoneScreen,
                        arguments: arguments,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Background Check",
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
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
