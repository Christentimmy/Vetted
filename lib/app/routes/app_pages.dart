import 'dart:ui';

import 'package:Vetted/app/modules/auth/views/otp_screen.dart';
import 'package:Vetted/app/modules/auth/views/phone_number_screen.dart';
import 'package:Vetted/app/modules/community/views/community_screen.dart';
import 'package:Vetted/app/modules/home/views/home_screen.dart';
import 'package:Vetted/app/modules/notificaton/views/allow_notification_screen.dart';
import 'package:Vetted/app/modules/onboarding/views/how_it_work_screen.dart';
import 'package:Vetted/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:Vetted/app/modules/onboarding/views/our_safety_tools_screen.dart';
import 'package:Vetted/app/modules/post/views/create_post_screen.dart';
import 'package:Vetted/app/modules/post/views/poll_post_screen.dart';
import 'package:Vetted/app/modules/post/views/woman_post_screen.dart';
import 'package:Vetted/app/modules/profile/views/date_of_birth_screen.dart';
import 'package:Vetted/app/modules/profile/views/input_name_screen.dart';
import 'package:Vetted/app/modules/profile/views/relationship_status_screen.dart';
import 'package:Vetted/app/modules/profile/views/set_location_screen.dart';
import 'package:Vetted/app/modules/settings/views/setting_screen.dart';
import 'package:Vetted/app/modules/splash/views/splash_screen.dart';
import 'package:Vetted/app/modules/verification/views/gender_verification_screen.dart';
import 'package:Vetted/app/modules/verification/views/selfie_disclaimer_screen.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/bottom_navigation_widget.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboardingScreen, page: () => OnboardingScreen()),
    GetPage(
      name: AppRoutes.otp,
      page: () {
        final phoneNumber = Get.arguments['phoneNumber'];
        final onTap = Get.arguments['onTap'];
        if (phoneNumber == null) {
          throw Exception('Phone number is required');
        }
        return OTPScreen(phoneNumber: phoneNumber, onTap: onTap);
      },
    ),
    GetPage(name: AppRoutes.phoneNumberScreen, page: () => PhoneNumberScreen()),
    GetPage(
      name: AppRoutes.inputNameScreen,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? {};
        final whatNext = arguments['whatNext'] as VoidCallback?;
        return InputNameScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.dateOfBirthScreen,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? {};
        final whatNext = arguments['whatNext'] as VoidCallback?;
        return DateOfBirthScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.relationshipStatusScreen,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? {};
        final whatNext = arguments['whatNext'] as VoidCallback?;
        return RelationshipStatusScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.setLocationScreen,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? {};
        final whatNext = arguments['whatNext'] as VoidCallback?;
        return SetLocationScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.selfieDisclaimer,
      page: () => const SelfieDisclaimerScreen(),
    ),
    GetPage(
      name: AppRoutes.genderVerificationScreen,
      page: () => GenderVerificationScreen(),
    ),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(
      name: AppRoutes.bottomNavigationWidget,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? {};
        final index = arguments['index'];
        return FloatingBottomNavigationWidget(index: index);
      },
    ),
    GetPage(name: AppRoutes.settingScreen, page: () => SettingScreen()),
    GetPage(
      name: AppRoutes.allowNotificationScreen,
      page: () => AllowNotificationScreen(),
    ),
    GetPage(name: AppRoutes.howItWorksScreen, page: () => HowItWorksScreen()),
    GetPage(
      name: AppRoutes.ourSafetyToolsScreen,
      page: () => OurSafetyToolsScreen(),
    ),
    GetPage(name: AppRoutes.communityScreen, page: () => CommunityScreen()),
    GetPage(name: AppRoutes.createPostScreen, page: () => CreatePostScreen()),
    GetPage(name: AppRoutes.womanPostScreen, page: () => WomanPostScreen()),
    GetPage(name: AppRoutes.pollPostScreen, page: () => PollPostScreen()),
  ];
}
