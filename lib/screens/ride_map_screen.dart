import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideMapScreen extends StatelessWidget {
  const RideMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خريطة الرحلة')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(36.7538, 3.0588),
          zoom: 12,
        ),
        markers: const {
          Marker(
            markerId: MarkerId('pickup'),
            position: LatLng(36.7538, 3.0588),
            infoWindow: InfoWindow(title: 'نقطة الانطلاق'),
          ),
          Marker(
            markerId: MarkerId('dropoff'),
            position: LatLng(36.7639, 3.0689),
            infoWindow: InfoWindow(title: 'الوجهة'),
          ),
        },
      ),
    );
  }
}
