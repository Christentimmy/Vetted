import 'package:Vetted/app/data/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutoCompleteController extends GetxController {
  final places = <Map<String, dynamic>>[].obs;
  final RxString searchText = ''.obs;
  final searchFieldController = TextEditingController();

  @override
  void onInit() {
    debounce(searchText, (String value) {
      if (value.isNotEmpty) {
        searchPlaces(value);
      } else {
        places.clear();
      }
    }, time: const Duration(milliseconds: 500));
    super.onInit();
  }

  void searchPlaces(String query) async {
    List<Map<String, dynamic>> results = await LocationService.searchPlaces(
      query,
    );
    if (results.isEmpty) return;
    places.value = results;
  }

  @override
  void dispose() {
    searchText.value = "";
    searchFieldController.clear();
    places.clear();
    super.dispose();
  }
}
