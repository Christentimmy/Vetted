import 'dart:math';
import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OffendersMapController extends GetxController {
  final appServiceController = Get.find<AppServiceController>();

  late GoogleMapController mapController;

  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxBool isFetching = false.obs;
  final RxBool mapInitialized = false.obs;

  LatLng? lastFetchLatLng;
  static const double minDistanceThreshold = 1000; // 1 km

  final LatLng startLatLng = const LatLng(41.9777476245164, -87.6472903440513);

  double _degToRad(double deg) => deg * (pi / 180.0);

  double _calculateDistance(LatLng p1, LatLng p2) {
    const earthRadius = 6371000; // meters
    final dLat = _degToRad(p2.latitude - p1.latitude);
    final dLon = _degToRad(p2.longitude - p1.longitude);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(p1.latitude)) *
            cos(_degToRad(p2.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  Future<void> fetchOffenders(
    double lat,
    double lng, {
    bool showLoader = false,
  }) async {
    if (isFetching.value) return;
    isFetching.value = true;

    if (showLoader) appServiceController.isloading.value = true;

    final offenders = await appServiceController.getOffendersOnMap(
      lat: lat,
      lng: lng,
      showLoader: showLoader,
    );

    if (offenders != null) {
      final Set<Marker> newMarkers = {};

      for (var offender in offenders) {
        final latitude = offender.sexOffenderLat;
        final longitude = offender.sexOffenderLon;
        final name =
            "${offender.sexOffenderFirstName} ${offender.sexOffenderLastName}";
        final position = LatLng(latitude, longitude);
        final markerId = "marker_${latitude}_$longitude";

        final alreadyExists = markers.any((m) => m.markerId.value == markerId);

        if (!alreadyExists) {
          newMarkers.add(
            Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange,
              ),
              markerId: MarkerId(markerId),
              position: position,
              infoWindow: InfoWindow(
                title: name,
                snippet: offender.sexOffenderCharges,
              ),
            ),
          );
        }
      }

      markers.addAll(newMarkers);
      lastFetchLatLng = LatLng(lat, lng);
    }

    isFetching.value = false;
    if (showLoader) appServiceController.isloading.value = false;
  }

  Future<void> handleCameraIdle(BuildContext context) async {
    final center = await mapController.getLatLng(
      ScreenCoordinate(
        x: MediaQuery.of(context).size.width ~/ 2,
        y: MediaQuery.of(context).size.height ~/ 2,
      ),
    );

    final zoom = await mapController.getZoomLevel();

    if (zoom < 10) {
      CustomSnackbar.showErrorToast("Zoom in to fetch offenders");
      return;
    }

    if (lastFetchLatLng != null) {
      final distance = _calculateDistance(lastFetchLatLng!, center);
      if (distance < minDistanceThreshold) return;
    }

    await fetchOffenders(center.latitude, center.longitude);
  }

  Future<void> handleTap(LatLng position) async {
    // if (lastFetchLatLng != null) {
    //   final distance = _calculateDistance(lastFetchLatLng!, position);
    //   if (distance < minDistanceThreshold) return;
    // }
    await fetchOffenders(
      position.latitude,
      position.longitude,
      showLoader: true,
    );
  }
}
