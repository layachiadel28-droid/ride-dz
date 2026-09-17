import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../screens/login_screen.dart';
import '../screens/rider_home_screen.dart';
import '../screens/driver_dashboard_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user == null) {
          return const LoginScreen();
        }

        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
              return const LoginScreen();
            }

            final data = userSnapshot.data!.data() ?? {};
            final role = data['role'] ?? 'rider';
            final approved = data['isApproved'] ?? false;

            if (role == 'driver') {
              if (!approved) {
                return const DriverPendingScreen();
              }
              return DriverDashboardScreen(driverId: user.uid);
            }

            return RiderHomeScreen(riderId: user.uid);
          },
        );
      },
    );
  }
}

class DriverPendingScreen extends StatelessWidget {
  const DriverPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حالة السائق')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'تم إنشاء حسابك، لكن الإدارة ما زالت تتحقق من بياناتك.
            انتظر تأكيد الموافقة.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
