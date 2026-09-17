import 'package:flutter/material.dart';

import '../services/pricing_service.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final pickupController = TextEditingController(text: 'وسط المدينة');
  final destinationController = TextEditingController(text: 'حي 5 جويلية');
  final priceController = TextEditingController(text: '500');

  double get distanceEstimate {
    return 5.0;
  }

  int get calculatedPrice {
    return PricingService.calculatePrice(
      pickupLat: 36.7538,
      pickupLng: 3.0588,
      dropoffLat: 36.7639,
      dropoffLng: 3.0689,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طلب رحلة')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: pickupController,
              decoration: const InputDecoration(
                labelText: 'نقطة الانطلاق',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: destinationController,
              decoration: const InputDecoration(
                labelText: 'الوجهة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'السعر المقترح (دج)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('التسعيرة'),
                        Text('10 دج / كلم'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المسافة التقديرية'),
                        Text('${distanceEstimate.toStringAsFixed(1)} كلم'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'السعر المحسوب',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${calculatedPrice} دج',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم إرسال طلب الرحلة بنجاح'),
                    ),
                  );
                },
                child: const Text('إرسال الطلب'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
