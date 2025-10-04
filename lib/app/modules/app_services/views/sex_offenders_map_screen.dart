// ignore_for_file: invalid_use_of_protected_member

import 'package:Vetted/app/modules/app_services/controller/offenders_map_controller.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SexOffendersMapScreen extends StatelessWidget {
  const SexOffendersMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OffendersMapController());

    return Scaffold(
      appBar: AppBar(title: const Text("Offenders Map")),
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
                controller.fetchOffenders(
                  controller.startLatLng.latitude,
                  controller.startLatLng.longitude,
                  showLoader: true,
                );
              },
              onTap: (position) => controller.handleTap(position),
              onCameraIdle: () => controller.handleCameraIdle(context),
              markers: controller.markers.value,
            );
          }),

          /// Loader overlay
          Obx(() {
            return controller.appServiceController.isloading.value
                ? const Center(child: Loader2())
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
