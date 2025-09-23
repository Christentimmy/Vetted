import 'package:Vetted/app/bindings/app_bindings.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_pages.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize("2fa250e8-3569-45a5-9c27-db2be9b84c36");
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
