import 'dart:convert';
import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/controller/socket_controller.dart';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/data/services/auth_service.dart';
import 'package:Vetted/app/data/services/user_service.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;
  final RxBool isOtpVerifyLoading = false.obs;
  final _authService = AuthService();
  final _userService = UserService();
  final _storageController = Get.find<StorageController>();

  //hold on idtoken
  final RxString tempToken = "".obs;

  Future<void> googleLoginOrSignUp() async {
    isGoogleLoading.value = true;
    try {
      final googleUser = await _authService.signInWithGoogle();
      if (googleUser == null) {
        return;
      }
      final googleAuth = googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      if (idToken == null) return;
      tempToken.value = idToken;
      final response = await _userService.userExist(email: googleUser.email);
      if (response == null) return;
      if (response.statusCode != 200) {
        // await googleAuthSignUp(idToken: idToken);
        Get.toNamed(AppRoutes.termsAndConditionScreen);
        return;
      }
      await googleAuthSignIn(idToken: idToken);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> googleAuthSignUp() async {
    isGoogleLoading.value = true;
    try {
      final response = await _authService.sendGoogleToken(
        token: tempToken.value,
        isRegister: true,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      debugPrint(decoded.toString());
      String message = decoded["message"] ?? "";
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final userController = Get.find<UserController>();
      String token = decoded["token"];
      await _storageController.storeToken(token);
      final socketController = Get.find<SocketController>();
      socketController.initializeSocket();
      await userController.getUserDetails();

      Get.toNamed(AppRoutes.howItWorksScreen);
      tempToken.value = "";
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> googleAuthSignIn({required String idToken}) async {
    isGoogleLoading.value = true;
    try {
      final response = await _authService.sendGoogleToken(
        token: idToken,
        isRegister: false,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      String token = decoded["token"] ?? "";
      final storageController = Get.find<StorageController>();
      await storageController.storeToken(token);

      if (response.statusCode == 405) {
        CustomSnackbar.showErrorToast(message);
        Get.offAllNamed(AppRoutes.selfieDisclaimer);
        return;
      }

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      final userController = Get.find<UserController>();
      await userController.getUserDetails();
      final socketController = Get.find<SocketController>();
      socketController.initializeSocket();
      Get.offAllNamed(AppRoutes.bottomNavigationWidget);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      final token = await _storageController.getToken();
      if (token == null) return;
      final response = await _authService.logout(token: token);
      if (response == null) return;
      if (response.statusCode != 200) return;
      await _storageController.deleteToken();
      Get.find<SocketController>().disconnectSocket();
      Get.find<UserController>().clean();
      Get.find<PostController>().clean();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loginWithNumber({required String phoneNumber}) async {
    isLoading.value = true;
    try {
      final response = await _authService.loginWithNumber(
        phoneNumber: phoneNumber,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      String token = decoded["token"] ?? "";
      String phone = decoded["phone"] ?? "";
      final storageController = Get.find<StorageController>();
      await storageController.storeToken(token);

      if (response.statusCode == 405) {
        CustomSnackbar.showErrorToast(message);
        Get.offAllNamed(AppRoutes.selfieDisclaimer);
        return;
      }

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      if (response.statusCode == 405) {
        CustomSnackbar.showErrorToast(message);
        Get.offAllNamed(
          AppRoutes.otp,
          arguments: {
            'phoneNumber': phone,
            'onTap': () {
              Get.offAllNamed(AppRoutes.bottomNavigationWidget);
            },
          },
        );
        return;
      }

      final userController = Get.find<UserController>();
      await userController.getUserDetails();
      final socketController = Get.find<SocketController>();
      socketController.initializeSocket();
      Get.offAllNamed(AppRoutes.bottomNavigationWidget);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerWithNumber({required String phoneNumber}) async {
    isLoading.value = true;
    try {
      HapticFeedback.lightImpact();
      if (phoneNumber.isEmpty) return;
      final reponse = await _authService.registerWithNumber(
        phoneNumber: phoneNumber,
      );
      if (reponse == null) return;
      final decoded = json.decode(reponse.body);
      String message = decoded["message"] ?? "";
      if (reponse.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      Get.toNamed(
        AppRoutes.otp,
        arguments: {
          'phoneNumber': phoneNumber,
          'onTap': () {
            Get.toNamed(AppRoutes.howItWorksScreen);
          },
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendNumberOtp({required String phoneNumber}) async {
    try {
      final response = await _authService.sendNumberOtp(
        phoneNumber: phoneNumber,
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
    }
  }

  Future<void> verifyNumberOtp({
    required String phoneNumber,
    required String otp,
    VoidCallback? whatNext,
  }) async {
    isOtpVerifyLoading.value = true;
    try {
      final response = await _authService.verifyNumberOtp(
        phoneNumber: phoneNumber,
        otp: otp,
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
      Get.toNamed(AppRoutes.inputNameScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isOtpVerifyLoading.value = false;
    }
  }
}
