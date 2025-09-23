import 'package:Vetted/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  final int distanceThreshold = 150;

  final isloading = false.obs;

  Future<LocationModel?> useMyCurrentLocation() async {
    isloading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return null;
    }

    try {
      Position initialPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        initialPosition.latitude,
        initialPosition.longitude,
      );

      return LocationModel(
        address: placemarks.first.subAdministrativeArea ?? "",
        coordinates: [initialPosition.latitude, initialPosition.longitude],
      );
    } catch (e) {
      print("Error fetching initial location: $e");
    } finally {
      isloading.value = false;
    }
    return null;
  }
}
