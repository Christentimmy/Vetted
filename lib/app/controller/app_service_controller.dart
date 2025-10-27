import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/controller/subscription_controller.dart';
import 'package:lottie/lottie.dart';
// import 'package:Vetted/app/data/models/background_check_model.dart';
import 'package:Vetted/app/data/models/criminal_record_model.dart';
import 'package:Vetted/app/data/models/eniform_phone_info_model.dart';
import 'package:Vetted/app/data/models/person_model.dart';
import 'package:Vetted/app/data/models/search_image_model.dart';
import 'package:Vetted/app/data/models/sex_offender_model.dart';
import 'package:Vetted/app/data/services/app_service.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppServiceController extends GetxController {
  //TODO: Pesons, personsBackground, Delete

  final isloading = false.obs;
  final isloadingByName = false.obs;
  final isloadingImage = false.obs;

  final AppService appService = AppService();
  RxList<PersonModel> numberInfoList = <PersonModel>[].obs;
  RxList<SearchImage> images = <SearchImage>[].obs;
  RxList<TinEyeImageModel> tinEyeImages = <TinEyeImageModel>[].obs;
  RxList<PersonModel> personsBackground = <PersonModel>[].obs;

  // final backgroundCheckList = <BackgroundCheckModel>[].obs;
  final criminalList = <CriminalRecordModel>[].obs;

  //new number data
  final eniformPhoneInfoModel = Rxn<EniformPhoneInfoModel>(null);
  final reverseInfoList = <ReverseInfoOnPhoneSearchModel>[].obs;

  Future<void> reverseImageSearch({required File file}) async {
    isloadingImage.value = true;

    try {
      Get.toNamed(AppRoutes.reverseImageScreen);
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;

      final response = await appService.imageSearch(file: file, token: token);
      if (response == null) return;
      final data = json.decode(response.body);
      String message = data["message"] ?? "";
      if (response.statusCode == 402) {
        displayTopUpDialog(message);
        return;
      }
      if (response.statusCode == 403) {
        CustomSnackbar.showErrorToast("You don't have access to this feature");
        Get.offNamed(AppRoutes.upgradePlanScreen);
        return;
      }
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      List<dynamic> result = data["data"] ?? [];
      if (result.isEmpty) {
        CustomSnackbar.showErrorToast("No data found");
        return;
      }
      // List<SearchImage> images =
      //     result.map((e) {
      //       final url = Uri.parse(e.toString());
      //       final host = url.host.replaceAll('www.', '');
      //       return SearchImage(imageUrl: e.toString(), source: host);
      //     }).toList();
      // this.images.value = images;
      // Get.toNamed(AppRoutes.reverseImageScreen);
      tinEyeImages.value =
          result.map((e) => TinEyeImageModel.fromJson(e)).toList();
      Get.toNamed(AppRoutes.reverseImageScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloadingImage.value = false;
    }
  }

  displayTopUpDialog(String message) {
    final subscriptionController = Get.find<SubscriptionController>();
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primaryColor, width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Lottie.asset(
                    "assets/images/Wallet.json",
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Sorry!!!",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        ontap: () => Get.toNamed(AppRoutes.upgradePlanScreen),
                        isLoading: false.obs,
                        bgColor: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: AppColors.primaryColor,
                        ),
                        child: Text(
                          "Subscribe",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        ontap: () async {
                          subscriptionController.createTopUp();
                        },
                        isLoading: subscriptionController.isLoading,
                        child: Text(
                          "Pay \$2.99",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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
      if (response.statusCode == 402) {
        displayTopUpDialog(message);
        return;
      }
      if (response.statusCode == 403) {
        CustomSnackbar.showErrorToast("You don't have access to this feature");
        Get.toNamed(AppRoutes.upgradePlanScreen);
        return;
      }

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final data = responseBody["data"];
      final enifromData = data["data"];
      String fullName = enifromData["fullName"];
      if (enifromData == null || fullName.contains("undefined")) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      final eniformPhoneInfoModel = EniformPhoneInfoModel.fromJson(enifromData);
      this.eniformPhoneInfoModel.value = eniformPhoneInfoModel;

      List<dynamic> reverseInfoData = data["reverseInfo"];
      if (reverseInfoData.isNotEmpty) {
        List<ReverseInfoOnPhoneSearchModel> mapped =
            reverseInfoData
                .map((e) => ReverseInfoOnPhoneSearchModel.fromJson(e))
                .toList();
        reverseInfoList.value = mapped;
      }
      Get.toNamed(AppRoutes.newNumberInfoScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> backgroundCheck({
    required String firstName,
    required String lastName,
    String? middleName,
    String? street,
    String? stateCode,
    String? city,
    String? zipCode,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;
      final response = await appService.backgroundCheck(
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        street: street,
        stateCode: stateCode,
        city: city,
        zipCode: zipCode,
        token: token,
      );
      if (response == null) return;
      final data = json.decode(response.body);
      String message = data["message"] ?? "";
      if (response.statusCode == 402) {
        displayTopUpDialog(message);
        return;
      }
      if (response.statusCode == 403) {
        CustomSnackbar.showErrorToast("You don't have access to this feature");
        Get.offNamed(AppRoutes.upgradePlanScreen);
        return;
      }
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
        arguments: {"name": firstName},
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
      if (response.statusCode == 402) {
        displayTopUpDialog(message);
        return null;
      }
      if (response.statusCode == 403) {
        CustomSnackbar.showErrorToast("You don't have access to this feature");
        Get.offNamed(AppRoutes.upgradePlanScreen);
        return null;
      }
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
    required String firstName,
    required String lastName,
    bool showLoader = true,
  }) async {
    isloadingByName.value = showLoader;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return null;

      final response = await appService.getSexOffenderByName(
        token: token,
        firstName: firstName,
        lastName: lastName,
      );
      if (response == null) return null;

      final data = json.decode(response.body);
      String message = data["message"] ?? "";
      if (response.statusCode == 402) {
        displayTopUpDialog(message);
        return null;
      }
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

  Future<void> getCriminalRecords({
    required String firstName,
    required String lastName,
    String? middleName,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;

      final response = await appService.getCriminalRecord(
        token: token,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
      );
      if (response == null) return;

      final data = json.decode(response.body);
      String message = data["message"] ?? "";
      if (response.statusCode == 402) {
        displayTopUpDialog(message);
        return;
      }
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      List result = data["data"] ?? [];
      if (result.isEmpty) {
        CustomSnackbar.showErrorToast("No data found");
        return;
      }

      List<CriminalRecordModel> criminals =
          result.map((e) => CriminalRecordModel.fromJson(e)).toList();
      criminalList.value = criminals;

      Get.toNamed(AppRoutes.allCriminalRecordsScreen);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}
