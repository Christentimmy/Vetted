import 'dart:ui';

import 'package:Vetted/app/bindings/app_bindings.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_pages.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize("2fa250e8-3569-45a5-9c27-db2be9b84c36");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // FirebaseCrashlytics.instance.crash();

  runApp(const VettedApp());
}

class VettedApp extends StatefulWidget {
  const VettedApp({super.key});

  @override
  State<VettedApp> createState() => _VettedAppState();
}

class _VettedAppState extends State<VettedApp> {
  final AppLinks _appLinks = AppLinks();

  final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.initDeepLinks(_appLinks);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vetted',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
          selectionHandleColor: AppColors.primaryColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      initialBinding: AppBindings(),
    );
  }
}
