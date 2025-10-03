import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/data/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SexOffendersMapScreen extends StatefulWidget {
  const SexOffendersMapScreen({super.key});

  @override
  State<SexOffendersMapScreen> createState() => _SexOffendersMapScreenState();
}

class _SexOffendersMapScreenState extends State<SexOffendersMapScreen> {
  late GoogleMapController mapController;
  final appServiceController = Get.find<AppServiceController>();

  final Set<Marker> _markers = {};

  Future<void> fetchOffenders(double lat, double lng) async {
    List<PersonModel>? offenders = await appServiceController.getOffendersOnMap(
      lat: lat,
      lng: lng,
    );
    if (offenders == null) return;

    setState(() {
      _markers.clear();
      for (var offender in offenders) {
        final latitude = offender.lat;
        final longitude = offender.lon;
        // final name = offender.name ?? "Unknown";
        final name = "Unknown";

        _markers.add(
          Marker(
            markerId: MarkerId(offender.id),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: name,
              snippet: "Unknow offense",
              // snippet: offender.offense ?? "Unknown offense",
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const startLatLng = LatLng(37.7749, -122.4194);
    return Scaffold(
      appBar: AppBar(title: const Text("Offenders Map")),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: startLatLng,
          zoom: 12,
        ),
        onMapCreated: (controller) {
          mapController = controller;
          fetchOffenders(startLatLng.latitude, startLatLng.longitude);
        },
        markers: _markers,
        onCameraIdle: () async {
          final center = await mapController.getLatLng(
            ScreenCoordinate(
              x: MediaQuery.of(context).size.width ~/ 2,
              y: MediaQuery.of(context).size.height ~/ 2,
            ),
          );
          await fetchOffenders(center.latitude, center.longitude);
        },
      ),
    );
  }
}
