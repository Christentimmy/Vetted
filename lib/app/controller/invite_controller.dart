import 'dart:convert';

import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/data/models/invite_model.dart';
import 'package:Vetted/app/data/services/invite_service.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteController extends GetxController {
  final isloading = false.obs;
  final _inviteService = InviteService();
  final Rxn<InviteModel> inviteModel = Rxn<InviteModel>();

  Future<void> getMyInviteCode() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;

      final response = await _inviteService.getMyInviteCode(token: token);
      if (response == null) return;

      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      Get.offNamed(AppRoutes.inviteStatsScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getInviteStats() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;

      final response = await _inviteService.getInviteStats(token: token);
      if (response == null) return;

      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final data = decoded["data"];
      if (data == null) return;
      final inviteModel = InviteModel.fromJson(data);
      this.inviteModel.value = inviteModel;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> redeemInvite({required String inviteCode}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;

      final response = await _inviteService.redeemInvite(
        token: token,
        inviteCode: inviteCode,
      );
      if (response == null) return;

      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      CustomSnackbar.showSuccessToast(
        "Gender application submitted successfully. You will be notified once it is approved.",
        toastDuration: Duration(seconds: 10),
      );
      Get.offAllNamed(AppRoutes.onboardingScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
