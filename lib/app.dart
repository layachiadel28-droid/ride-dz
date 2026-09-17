import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'services/auth_service.dart';
import 'screens/auth_gate.dart';

class FirebaseSetup {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}

class RideApp extends StatelessWidget {
  const RideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride DZ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
