import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/data/models/person_model.dart';
import 'package:Vetted/app/data/models/search_image_model.dart';
import 'package:Vetted/app/data/services/app_service.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppServiceController extends GetxController {
  final isloading = false.obs;
  final isloadingImage = false.obs;
  final AppService appService = AppService();
  RxList<PersonModel> persons = <PersonModel>[].obs;
  RxList<SearchImage> images = <SearchImage>[].obs;

  Future<void> reverseImageSearch({required File file}) async {
    isloadingImage.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;
      final response = await appService.imageSearch(file: file, token: token);
      if (response == null) return;
      final data = json.decode(response.body);
      String message = data["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      List<dynamic> result = data["data"]?["images"] ?? [];
      if (result.isEmpty) {
        CustomSnackbar.showErrorToast("No data found");
        return;
      }
      List<SearchImage> images =
          result.map((e) => SearchImage.fromJson(e)).toList();
      this.images.value = images;
      Get.toNamed(AppRoutes.reverseImageScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloadingImage.value = false;
    }
  }

  Future<void> getNumberInfo({required String number}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;
      final response = await appService.getNumberInfo(
        phoneNumber: number,
        token: token,
      );
      if (response == null) return;
      final data = json.decode(response.body);
      String message = data["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      List result = data["data"] ?? [];
      if (result.isEmpty) {
        CustomSnackbar.showErrorToast("No data found");
        return;
      }
      List<PersonModel> persons =
          result.map((e) => PersonModel.fromJson(e)).toList();
      this.persons.value = persons;
      Get.toNamed(AppRoutes.numberCheckScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

}
