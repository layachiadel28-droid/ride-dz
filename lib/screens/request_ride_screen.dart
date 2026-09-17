import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/pricing_service.dart';
import 'pick_location_screen.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  LatLng? pickup;
  LatLng? destination;

  int get calculatedPrice => pickup == null || destination == null
      ? 0
      : PricingService.calculatePrice(
          pickupLat: pickup!.latitude,
          pickupLng: pickup!.longitude,
          dropoffLat: destination!.latitude,
          dropoffLng: destination!.longitude,
        );

  Future<void> _selectPickup() async {
    final result = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (_) => const PickLocationScreen(title: 'نقطة الانطلاق'),
      ),
    );
    if (result != null) setState(() => pickup = result);
  }

  Future<void> _selectDestination() async {
    final result = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (_) => const PickLocationScreen(title: 'الوجهة'),
      ),
    );
    if (result != null) setState(() => destination = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طلب رحلة')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            InkWell(
              onTap: _selectPickup,
              child: _LocationCard(
                title: 'نقطة الانطلاق',
                value: pickup == null ? 'لم يتم الاختيار' : '${pickup!.latitude}, ${pickup!.longitude}',
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _selectDestination,
              child: _LocationCard(
                title: 'الوجهة',
                value: destination == null ? 'لم يتم الاختيار' : '${destination!.latitude}, ${destination!.longitude}',
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('السعر المتوقع', style: TextStyle(fontSize: 18)),
                    Text('$calculatedPrice دج', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: pickup == null || destination == null ? null : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إرسال طلب الرحلة')),
                  );
                },
                child: const Text('إرسال الطلب'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String title;
  final String value;

  const _LocationCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(value, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
