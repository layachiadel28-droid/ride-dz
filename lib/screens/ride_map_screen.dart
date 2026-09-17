import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideMapScreen extends StatelessWidget {
  const RideMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const initialCamera = CameraPosition(
      target: LatLng(36.7538, 3.0588),
      zoom: 12,
    );

    final markers = <Marker>{
      const Marker(
        markerId: MarkerId('pickup'),
        position: LatLng(36.7538, 3.0588),
        infoWindow: InfoWindow(title: 'نقطة الانطلاق'),
      ),
      const Marker(
        markerId: MarkerId('dropoff'),
        position: LatLng(36.7639, 3.0689),
        infoWindow: InfoWindow(title: 'الوجهة'),
      ),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('تتبع الرحلة')),
      body: GoogleMap(
        initialCameraPosition: initialCamera,
        markers: markers,
        myLocationEnabled: true,
      ),
    );
  }
}
