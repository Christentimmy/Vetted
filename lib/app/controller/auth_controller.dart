import 'dart:convert';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/data/services/auth_service.dart';
import 'package:Vetted/app/routes/app_routes.dart';
// import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
 final RxBool isLoading = false.obs;
 final RxBool isGoogleLoading = false.obs;
  final RxBool isOtpVerifyLoading = false.obs;
  final _authService = AuthService();
  final _storageController = Get.find<StorageController>();

  Future<void> googleAuthSignUp() async {
    isGoogleLoading.value = true;
    try {
      final idToken = await _authService.signInWithGoogle();
      if (idToken == null) {
        return;
      }
      final response = await _authService.sendGoogleToken(
        token: idToken,
        isRegister: true,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      // final userController = Get.find<UserController>();
      String token = decoded["token"];
      await _storageController.storeToken(token);
      // final socketController = Get.find<SocketController>();
      // socketController.initializeSocket();
      // await userController.getUserDetails();
      Get.toNamed(AppRoutes.inputNameScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> googleAuthSignIn() async {
    isGoogleLoading.value = true;
    try {
      final idToken = await _authService.signInWithGoogle();
      if (idToken == null) {
        CustomSnackbar.showErrorToast("Failed to sign in with Google");
        return;
      }
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
      if (response.statusCode == 404) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      if (response.statusCode == 402) {
        CustomSnackbar.showErrorToast(message);
        // Get.offAllNamed(AppRoutes.signup);
        return;
      }
      // final socketController = Get.find<SocketController>();
      // await socketController.initializeSocket();

      if (response.statusCode == 400) {
        CustomSnackbar.showErrorToast(message);
        // Get.offAllNamed(AppRoutes.completeProfile);
        return;
      }
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      // final userController = Get.find<UserController>();
      // await userController.getUserDetails();
      // Get.offAllNamed(AppRoutes.bottomNavigation);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  } 

}
