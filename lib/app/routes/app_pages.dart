import 'dart:ui';

import 'package:Vetted/app/data/models/chat_list_model.dart';
import 'package:Vetted/app/data/models/person_model.dart';
import 'package:Vetted/app/modules/app_services/views/background_check_search_result_screen.dart';
import 'package:Vetted/app/modules/app_services/views/background_check_search_screen.dart';
import 'package:Vetted/app/modules/app_services/views/background_result_more_details_done_screen.dart';
import 'package:Vetted/app/modules/app_services/views/number_check_screen.dart';
import 'package:Vetted/app/modules/app_services/views/reverse_image_screen.dart';
import 'package:Vetted/app/modules/auth/views/otp_screen.dart';
import 'package:Vetted/app/modules/auth/views/phone_number_screen.dart';
import 'package:Vetted/app/modules/chat/views/chat_screen.dart';
import 'package:Vetted/app/modules/community/views/community_screen.dart';
import 'package:Vetted/app/modules/home/views/home_screen.dart';
import 'package:Vetted/app/modules/notification/views/notification_screen.dart';
import 'package:Vetted/app/modules/notificaton/views/allow_notification_screen.dart';
import 'package:Vetted/app/modules/onboarding/views/how_it_work_screen.dart';
import 'package:Vetted/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:Vetted/app/modules/onboarding/views/our_safety_tools_screen.dart';
import 'package:Vetted/app/modules/post/views/create_post_screen.dart';
import 'package:Vetted/app/modules/post/views/poll_post_screen.dart';
import 'package:Vetted/app/modules/post/views/post_screen.dart';
import 'package:Vetted/app/modules/post/views/upgrade_plan_screen.dart';
import 'package:Vetted/app/modules/post/views/woman_post_screen.dart';
import 'package:Vetted/app/modules/profile/views/date_of_birth_screen.dart';
import 'package:Vetted/app/modules/profile/views/edit_profile_screen.dart';
import 'package:Vetted/app/modules/profile/views/input_name_screen.dart';
import 'package:Vetted/app/modules/profile/views/relationship_status_screen.dart';
import 'package:Vetted/app/modules/profile/views/set_location_screen.dart';
import 'package:Vetted/app/modules/settings/views/court_resources_screen.dart';
import 'package:Vetted/app/modules/settings/views/my_alerts_screen.dart';
import 'package:Vetted/app/modules/settings/views/my_post_screen.dart';
import 'package:Vetted/app/modules/settings/views/saved_post_screen.dart';
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
    GetPage(
      name: AppRoutes.phoneNumberScreen,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? {};
        final isSignUp = arguments['isSignUp'] as bool? ?? false;
        return PhoneNumberScreen(isSignUp: isSignUp);
      },
    ),
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
    GetPage(name: AppRoutes.postScreen, page: () => PostScreen()),
    GetPage(name: AppRoutes.numberCheckScreen, page: () => NumberCheckScreen()),
    GetPage(
      name: AppRoutes.reverseImageScreen,
      page: () => ReverseImageScreen(),
    ),
    GetPage(
      name: AppRoutes.backgroundCheckSearchScreen,
      page: () => BackgroundCheckSearchScreen(),
    ),
    GetPage(
      name: AppRoutes.backgroundCheckSearchResultScreen,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? {};
        final name = arguments['name'] as String?;
        if (name == null) {
          throw Exception("Name is required");
        }
        return BackgroundCheckSearchResultScreen(name: name);
      },
    ),
    GetPage(
      name: AppRoutes.backgroundResultMoreDetailsDoneScreen,
      page: () {
        final arguments = Get.arguments as Map<String, dynamic>? ?? {};
        final person = arguments['person'] as PersonModel?;
        if (person == null) {
          throw Exception("Name is required");
        }
        return BackgroundResultMoreDetailsScreen(person: person);
      },
    ),
    GetPage(
      name: AppRoutes.chatScreen,
      page: () {
        final arguments = Get.arguments as Map;
        final chatHead = arguments['chatHead'] as ChatListModel?;
        if (chatHead == null) {
          throw Exception("Chat ID is required");
        }
        return ChatScreen(chatHead: chatHead);
      },
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationScreen(),
    ),
    GetPage(name: AppRoutes.editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: AppRoutes.myPostScreen, page: () => MyPostScreen()),
    GetPage(name: AppRoutes.savedPostScreen, page: () => SavedPostScreen()),
    GetPage(name: AppRoutes.myAlertsScreen, page: () => MyAlertsScreen()),
    GetPage(name: AppRoutes.upgradePlanScreen, page: () => UpgradePlanScreen()),
    GetPage(name: AppRoutes.courtStateResources, page: () => CourtResourcesScreen()),
  ];
}
