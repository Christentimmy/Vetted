import 'package:Vetted/app/bindings/app_bindings.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_pages.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const VettedApp());
}

class VettedApp extends StatelessWidget {
  const VettedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vetted',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      initialBinding: AppBindings(),
    );
  }
}
