import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/data/models/eniform_phone_info_model.dart';
import 'package:Vetted/app/data/models/person_model.dart';
import 'package:Vetted/app/data/models/search_image_model.dart';
import 'package:Vetted/app/data/models/sex_offender_model.dart';
import 'package:Vetted/app/data/services/app_service.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppServiceController extends GetxController {
  final isloading = false.obs;
  final isloadingByName = false.obs;
  final isloadingImage = false.obs;
  final AppService appService = AppService();
  RxList<PersonModel> persons = <PersonModel>[].obs;
  RxList<SearchImage> images = <SearchImage>[].obs;
  RxList<PersonModel> personsBackground = <PersonModel>[].obs;

  //new number data
  final eniformPhoneInfoModel = EniformPhoneInfoModel().obs;
  RxList<ReverseInfoOnPhoneSearchModel> reverseInfoList =
      <ReverseInfoOnPhoneSearchModel>[].obs;

  Future<void> reverseImageSearch({required File file}) async {
    isloadingImage.value = true;

    try {
      Get.toNamed(AppRoutes.reverseImageScreen);
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;

      final stopWatch = Stopwatch()..start();
      final response = await appService.imageSearch(file: file, token: token);
      stopWatch.stop();
      debugPrint("Time taken: ${stopWatch.elapsed}");
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
      // Get.toNamed(AppRoutes.reverseImageScreen);
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
      final responseBody = json.decode(response.body);
      String message = responseBody["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final data = responseBody["data"];
      final enifromData = data["data"];
      print("EniformData: =============== $enifromData");
      if (enifromData == null) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final eniformPhoneInfoModel = EniformPhoneInfoModel.fromJson(enifromData);
      this.eniformPhoneInfoModel.value = eniformPhoneInfoModel;

      List<dynamic> reverseInfoData = data["reverseInfo"];
      print("ReverseInfoData: =============== $reverseInfoData");
      if (reverseInfoData.isNotEmpty) {
        List<ReverseInfoOnPhoneSearchModel> mapped =
            reverseInfoData
                .map((e) => ReverseInfoOnPhoneSearchModel.fromJson(e))
                .toList();
        reverseInfoList.value = mapped;
      }
      print("FullName: =============== ${eniformPhoneInfoModel.fullName}");
      Get.toNamed(AppRoutes.newNumberInfoScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> backgroundCheck({
    required String name,
    required String street,
    required String stateCode,
    required String city,
    required String zipCode,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;
      final response = await appService.backgroundCheck(
        name: name,
        street: street,
        stateCode: stateCode,
        city: city,
        zipCode: zipCode,
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
      List<PersonModel> incomingPersons =
          result.map((e) => PersonModel.fromJson(e)).toList();
      personsBackground.value = incomingPersons;
      Get.toNamed(
        AppRoutes.backgroundCheckSearchResultScreen,
        arguments: {"name": name},
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<List<OffenderModel>?> getOffendersOnMap({
    required double lat,
    required double lng,
    bool showLoader = true,
  }) async {
    isloading.value = showLoader;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return null;

      final response = await appService.getOffendersMap(
        lat: lat,
        lng: lng,
        radius: 5,
        token: token,
      );
      if (response == null) return null;

      final data = json.decode(response.body);
      String message = data["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return null;
      }
      List result = data["data"] ?? [];
      if (result.isEmpty) {
        CustomSnackbar.showErrorToast("No data found");
        return null;
      }
      List<OffenderModel> peopleOnMap =
          result.map((e) => OffenderModel.fromJson(e)).toList();
      return peopleOnMap;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
    return null;
  }

  Future<List<OffenderModel>?> getSexOffenderByName({
    required String name,
    bool showLoader = true,
  }) async {
    isloadingByName.value = showLoader;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return null;

      final response = await appService.getSexOffenderByName(
        token: token,
        name: name,
      );
      if (response == null) return null;

      final data = json.decode(response.body);
      String message = data["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return null;
      }
      List result = data["data"] ?? [];
      if (result.isEmpty) {
        CustomSnackbar.showErrorToast("No data found");
        return null;
      }
      List<OffenderModel> peopleOnMap =
          result.map((e) => OffenderModel.fromJson(e)).toList();
      return peopleOnMap;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloadingByName.value = false;
    }
    return null;
  }
}
