import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RiderHomeScreen extends StatelessWidget {
  final String riderId;

  const RiderHomeScreen({required this.riderId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        actions: [
          IconButton(
            onPressed: () => AuthService().logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('أنت راكب', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    // navigation to request screen next
                  },
                  icon: const Icon(Icons.local_taxi),
                  label: const Text('طلب رحلة'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
