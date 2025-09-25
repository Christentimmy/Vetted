import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/data/models/notification_model.dart';
import 'package:Vetted/app/data/models/user_model.dart';
import 'package:Vetted/app/data/services/user_service.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class UserController extends GetxController {
  final _userService = UserService();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  RxBool isloading = false.obs;
  RxBool isUserDetailsFetched = false.obs;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;

  Future<void> getUserDetails() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserDetails(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (message == "Token has expired.") {
        Get.offAllNamed(AppRoutes.onboardingScreen);
        return;
      }

      if (response.statusCode != 200) {
        debugPrint("Error-from-get-user-details: $message");
        return;
      }

      var userData = decoded["data"];
      UserModel mapped = UserModel.fromJson(userData);
      userModel.value = mapped;
      userModel.refresh();
      if (response.statusCode == 200) isUserDetailsFetched.value = true;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateName({
    required String name,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.updateName(token: token, name: name);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      if (whatNext != null) {
        whatNext();
        return;
      }
      Get.toNamed(AppRoutes.dateOfBirthScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateDob({
    required DateTime dateOfBirth,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.updateDob(
        token: token,
        dateOfBirth: dateOfBirth,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      if (whatNext != null) {
        whatNext();
        return;
      }
      Get.toNamed(AppRoutes.relationshipStatusScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateRelationStatus({
    required String relationStatus,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.updateRelationStatus(
        token: token,
        relationStatus: relationStatus,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      if (whatNext != null) {
        whatNext();
        return;
      }
      Get.toNamed(AppRoutes.setLocationScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateLocation({
    required LocationModel location,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      final response = await _userService.updateLocation(
        token: token,
        location: location,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      if (whatNext != null) {
        whatNext();
        return;
      }
      Get.toNamed(AppRoutes.selfieDisclaimer);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<String?> verifyGender({required File file}) async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return null;
      final response = await _userService.verifyGender(
        token: token,
        videoFile: file,
      );
      if (response == null) return null;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      String gender = decoded["data"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return null;
      }
      return gender.toLowerCase();
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> getUserStatus() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        Get.offAllNamed(AppRoutes.onboardingScreen);
        return;
      }

      final response = await _userService.getUserStatus(token: token);
      if (response == null) {
        Get.offAllNamed(AppRoutes.onboardingScreen);
        return;
      }
      final decoded = json.decode(response.body);
      String message = decoded["message"];

      if (response.statusCode != 200 || message == "Token has expired.") {
        Get.offAllNamed(AppRoutes.onboardingScreen);
        return;
      }

      var userData = decoded["data"];
      if (userData == null) {
        Get.offAllNamed(AppRoutes.onboardingScreen);
        return;
      }

      String accountStatus = userData["accountStatus"] ?? "";
      String phone = userData["phone"] ?? "";

      bool isPhoneVerified = userData["isPhoneVerified"] ?? false;
      if (accountStatus.isEmpty || accountStatus != "active") {
        Get.offAllNamed(AppRoutes.onboardingScreen);
        return;
      }

      if (!isPhoneVerified && phone.isNotEmpty) {
        Get.offAllNamed(
          AppRoutes.otp,
          arguments: {
            "phoneNumber": userData["phone"],
            "onTap": () async {
              await getUserStatus();
            },
          },
        );
        return;
      }

      String relationStatus = userData["relationshipStatus"] ?? "";
      if (relationStatus.isEmpty) {
        Get.offAllNamed(
          AppRoutes.relationshipStatusScreen,
          arguments: {
            "whatNext": () async {
              await getUserStatus();
            },
          },
        );
        return;
      }

      String displayName = userData["displayName"] ?? "";
      if (displayName.isEmpty) {
        Get.offAllNamed(
          AppRoutes.inputNameScreen,
          arguments: {
            "whatNext": () async {
              await getUserStatus();
            },
          },
        );
        return;
      }

      String dob = userData["dateOfBirth"] ?? "";
      if (dob.isEmpty) {
        Get.offAllNamed(
          AppRoutes.dateOfBirthScreen,
          arguments: {
            "whatNext": () async {
              await getUserStatus();
            },
          },
        );
        return;
      }

      String location = userData["location"]["address"] ?? "";
      if (location.isEmpty) {
        Get.offAllNamed(
          AppRoutes.setLocationScreen,
          arguments: {
            "whatNext": () async {
              await getUserStatus();
            },
          },
        );
        return;
      }

      bool isProfileCompleted = userData["isProfileCompleted"] ?? false;
      if (!isProfileCompleted) {
        Get.offAllNamed(AppRoutes.selfieDisclaimer);
        return;
      }

      Get.offAllNamed(AppRoutes.bottomNavigationWidget);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> saveUserOneSignalId() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;
      bool isPermission = OneSignal.Notifications.permission;
      if (!isPermission) {
        OneSignal.Notifications.requestPermission(true);
      }

      final userId = userModel.value?.id;
      final subId = OneSignal.User.pushSubscription.id;
      if (userId == null || subId == null) return;

      final lastSaved = await storageController.getLastPushId(userId);
      if (lastSaved == subId) {
        return;
      }
      final response = await _userService.saveUserOneSignalId(
        token: token,
        id: subId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      await storageController.saveLastPushId(
        userId: userId,
        oneSignalId: subId,
      );
      Get.offAllNamed(AppRoutes.inputNameScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> reportUser({
    required String type,
    required String reason,
    required String reportedUser,
    required String referenceId,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null) return;
      final response = await _userService.reportUser(
        token: token,
        type: type,
        reason: reason,
        reportedUser: reportedUser,
        referenceId: referenceId,
      );
      if (response == null) return;
      var responseBody = json.decode(response.body);
      String message = responseBody["message"] ?? "";
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      Navigator.pop(Get.context!);
      CustomSnackbar.showSuccessToast("Report submitted successfully");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> toggleBlock({required String blockId}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;
      final response = await _userService.toggleBlock(
        token: token,
        blockId: blockId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      CustomSnackbar.showSuccessToast(message);
      // await getBlockedUsers(showLoader: false);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> toggleFollow({required String userId}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;
      final response = await _userService.toggleFollow(
        token: token,
        userId: userId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      CustomSnackbar.showSuccessToast(message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getNotifications({bool showLoader = true}) async {
    isloading.value = showLoader;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await _userService.getNotification(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      List<dynamic> data = decoded["data"] ?? [];
      final notifications =
          data.map((e) => NotificationModel.fromJson(e)).toList();
      notificationList.value = notifications;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> markNotificationAsRead({required String id}) async {
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await _userService.markNotificationAsRead(
        token: token,
        id: id,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> editProfile({required UserModel userModel}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await _userService.editProfile(
        token: token,
        userModel: userModel,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      await getUserDetails();
      CustomSnackbar.showSuccessToast(message);
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  void clean() {
    userModel.value = null;
    isUserDetailsFetched.value = false;
    notificationList.clear();
    isloading.value = false;
  }
}
