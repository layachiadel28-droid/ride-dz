import 'package:flutter/material.dart';

class DriverDashboardScreen extends StatelessWidget {
  final String driverId;

  const DriverDashboardScreen({required this.driverId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة السائق'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('السائق جاهز لاستقبال الرحلات'),
      ),
    );
  }
}
