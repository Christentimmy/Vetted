import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCriminalRecordsScreen extends StatelessWidget {
  AllCriminalRecordsScreen({super.key});

  final appServiceController = Get.find<AppServiceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: appServiceController.criminalList.length,
        itemBuilder: (context, index) {
          final criminal = appServiceController.criminalList[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              onTap: () {
                Get.toNamed(
                  AppRoutes.criminalRecordScreen,
                  arguments: {"criminal": criminal},
                );
              },
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Text(
                  criminal.name.toString().split(" ")[0].substring(0, 1),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                criminal.name.toString(),
                style: GoogleFonts.fredoka(
                  color: AppColors.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                criminal.offense.toString(),
                style: GoogleFonts.fredoka(
                  // color: AppColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'All Criminal Records',
        style: GoogleFonts.poppins(
          color: AppColors.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 1,
    );
  }
}
