// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';
import 'dart:ui';
import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/data/models/sex_offender_model.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OffendersMapController extends GetxController {
  final appServiceController = Get.find<AppServiceController>();
  final searchText = RxString('');
  final searchController = TextEditingController();

  final RxDouble cardOffset = 0.0.obs;
  final double dismissThreshold = 150.0;

  late GoogleMapController mapController;
  final Rx<OffenderModel?> sexOffender = Rx<OffenderModel?>(null);

  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxBool isFetching = false.obs;
  final RxBool mapInitialized = false.obs;

  LatLng? lastFetchLatLng;
  static const double minDistanceThreshold = 1000;

  final LatLng startLatLng = const LatLng(41.9777476245164, -87.6472903440513);

  //My tactics
  final RxSet<Marker> holdMarkers = <Marker>{}.obs;

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
    if (searchText.value.isNotEmpty) {
      return;
    }

    if (showLoader) appServiceController.isloading.value = true;

    final offenders = await appServiceController.getOffendersOnMap(
      lat: lat,
      lng: lng,
      showLoader: showLoader,
    );

    final icon = await _createCircleMarker(size: 50, color: Colors.redAccent);

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
              icon: icon,
              markerId: MarkerId(markerId),
              position: position,
              infoWindow: InfoWindow(
                title: name,
                snippet: offender.sexOffenderCharges,
              ),
              onTap: () {
                sexOffender.value = offender;
              },
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
    if (searchText.value.isNotEmpty) {
      return;
    }
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

    sexOffender.value = null;
    if (searchText.value.isNotEmpty) {
      return;
    }
    await fetchOffenders(
      position.latitude,
      position.longitude,
      showLoader: true,
    );
  }

  Future<BitmapDescriptor> _createCircleMarker({
    double size = 20,
    Color color = AppColors.primaryColor,
  }) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final paint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2;
    final paint2 = Paint()..color = color;

    final center = Offset(size / 2, size / 2);
    canvas.drawCircle(center, size / 2, paint);
    canvas.drawCircle(center, size / 2 - 2, paint2);

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final bytes = await image.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  void cleanField() {
    searchText.value = '';
    searchController.clear();
    markers.value = holdMarkers;
    holdMarkers.value.clear();
    return;
  }

  Future<void> searchNameonMap() async {
    HapticFeedback.lightImpact();
    sexOffender.value = null;
    FocusManager.instance.primaryFocus?.unfocus();
    if (searchText.value.isEmpty) {
      CustomSnackbar.showErrorToast("Please enter a name");
      return;
    }
    final allOffendersList = await appServiceController.getSexOffenderByName(
      name: searchText.value,
    );
    if (allOffendersList == null) return;
    holdMarkers.value = markers;
    markers.clear();

    final icon = await _createCircleMarker(size: 50, color: Colors.redAccent);
    for (var element in allOffendersList) {
      final latitude = element.sexOffenderLat;
      final longitude = element.sexOffenderLon;
      final name = element.sexOffenderName;
      final position = LatLng(latitude, longitude);
      final markerId = "marker_${latitude}_$longitude";

      markers.add(
        Marker(
          icon: icon,
          markerId: MarkerId(markerId),
          position: position,
          infoWindow: InfoWindow(
            title: name,
            snippet: element.sexOffenderCharges,
          ),
          onTap: () {
            sexOffender.value = element;
          },
        ),
      );
    }
    await mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          allOffendersList.first.sexOffenderLat,
          allOffendersList.first.sexOffenderLon,
        ),
        12,
      ),
    );
  }

  @override
  void onClose() {
    markers.value.clear();
    holdMarkers.value.clear();
    sexOffender.value = null;
    searchText.value = '';
    searchController.clear();
    mapController.dispose();
    isFetching.value = false;
    mapInitialized.value = false;
    lastFetchLatLng = null;
    appServiceController.isloading.value = false;
    super.onClose();
  }

}
