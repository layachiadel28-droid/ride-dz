import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationScreen extends StatefulWidget {
  final String title;

  const PickLocationScreen({required this.title, super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  LatLng? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(36.7538, 3.0588),
              zoom: 12,
            ),
            onTap: (location) {
              setState(() => selected = location);
            },
            markers: selected == null
                ? const {}
                : {
                    Marker(
                      markerId: const MarkerId('picked'),
                      position: selected!,
                    ),
                  },
          ),
          Positioned(
            bottom: 20,
            right: 16,
            left: 16,
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: selected == null
                    ? null
                    : () => Navigator.pop(context, selected),
                child: const Text('تأكيد المكان'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
