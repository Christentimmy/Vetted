import 'package:Vetted/app/modules/auth/views/phone_number_screen.dart';
import 'package:Vetted/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:Vetted/app/modules/profile/views/date_of_birth_screen.dart';
import 'package:Vetted/app/modules/profile/views/input_name_screen.dart';
import 'package:Vetted/app/modules/profile/views/relationship_status_screen.dart';
import 'package:Vetted/app/modules/profile/views/set_location_screen.dart';
import 'package:Vetted/app/modules/splash/views/splash_screen.dart';
import 'package:Vetted/app/modules/verification/views/selfie_verification_screen.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/screens/otp_login_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboardingScreen, page: () => OnboardingScreen()),
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
    GetPage(
      name: AppRoutes.phoneNumberScreen,
      page: () => const PhoneNumberScreen(),
    ),
    GetPage(name: AppRoutes.inputNameScreen, page: () => InputNameScreen()),
    GetPage(
      name: AppRoutes.dateOfBirthScreen,
      page: () => const DateOfBirthScreen(),
    ),
    GetPage(
      name: AppRoutes.relationshipStatusScreen,
      page: () => const RelationshipStatusScreen(),
    ),
    GetPage(name: AppRoutes.setLocationScreen, page: () => SetLocationScreen()),
    GetPage(
      name: AppRoutes.selfieVerificationScreen,
      page: () => const SelfieVerificationScreen(),
    ),
  ];
}
