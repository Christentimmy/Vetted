import 'package:Vetted/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:Vetted/app/modules/splash/views/splash_screen.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/screens/otp_login_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(
      name: AppRoutes.onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () {
        final phoneNumber = Get.arguments['phoneNumber'];
        if (phoneNumber == null) {
          throw Exception('Phone number is required');
        }
        return OTPScreen(phoneNumber: phoneNumber);
      },
    ),
  ];
}
