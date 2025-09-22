import 'dart:convert';

import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/data/models/user_model.dart';
import 'package:Vetted/app/data/services/user_service.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _userService = UserService();
  Rxn<UserModel> userModel = Rxn<UserModel>();
  RxBool isloading = false.obs;
  RxBool isUserDetailsFetched = false.obs;

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

  Future<void> updateName({required String name}) async {
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
      Get.toNamed(AppRoutes.dateOfBirthScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

}
