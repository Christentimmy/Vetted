// ignore_for_file: invalid_use_of_protected_member

import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/modules/app_services/controller/offenders_map_controller.dart';
import 'package:Vetted/app/modules/app_services/widgets/sex_offenders._widget.dart';
import 'package:Vetted/app/modules/post/widgets/custom_textfield.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SexOffendersMapScreen extends StatelessWidget {
  SexOffendersMapScreen({super.key});

  final appServiceController = Get.find<AppServiceController>();
  final controller = Get.put(OffendersMapController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offenders Map")),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.startLatLng,
                zoom: 12,
              ),
              onMapCreated: (mapCtrl) {
                if (controller.mapInitialized.value) return;
                controller.mapController = mapCtrl;
                controller.mapInitialized.value = true;
                // controller.fetchOffenders(
                //   controller.startLatLng.latitude,
                //   controller.startLatLng.longitude,
                //   showLoader: true,
                // );
              },
              // onTap: (position) => controller.handleTap(position),
              // onCameraIdle: () => controller.handleCameraIdle(context),
              markers: controller.markers.value,
            );
          }),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return CustomTextField(
                      controller: controller.searchController,
                      prefixIcon: Icons.search,
                      bgColor: Colors.white,
                      hintText: "Search by name",
                      onChanged: (value) => controller.searchText.value = value,
                      suffixIcon:
                          controller.searchText.value.isNotEmpty
                              ? Icons.clear
                              : null,
                      suffixIconcolor: AppColors.primaryColor,
                      onSuffixTap: controller.cleanField,
                    );
                  }),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: controller.searchNameonMap,
                    child: Obx(() {
                      if (appServiceController.isloadingByName.value) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      return Text(
                        "Search",
                        style: GoogleFonts.poppins(color: Colors.white),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          Obx(() {
            final offender = controller.sexOffender.value;
            if (offender == null) return const SizedBox.shrink();
            ;
            return BuildOffenderCard(
              controller: controller,
              offender: offender,
            );
          }),

          Obx(() {
            return appServiceController.isloading.value
                ? const Center(child: Loader2())
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
