import 'package:flutter/material.dart';

import 'ride_map_screen.dart';
import 'ride_request_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.local_taxi, size: 90, color: Colors.green),
              const SizedBox(height: 24),
              const Text('Ride DZ', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('نقل آمن وبسعر واضح', textAlign: TextAlign.center),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen())),
                icon: const Icon(Icons.login),
                label: const Text('تسجيل الدخول'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen())),
                icon: const Icon(Icons.person_add),
                label: const Text('إنشاء حساب'),
              ),
              const SizedBox(height: 18),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AdminDashboardScreen())),
                child: const Text('لوحة الإدارة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const TextField(decoration: InputDecoration(labelText: 'الإيميل', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          const TextField(obscureText: true, decoration: InputDecoration(labelText: 'كلمة المرور', border: OutlineInputBorder())),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: FilledButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RiderHomeScreen())),
            child: const Text('دخول'),
          )),
        ]),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const TextField(decoration: InputDecoration(labelText: 'الاسم الكامل', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'الإيميل', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          const TextField(obscureText: true, decoration: InputDecoration(labelText: 'كلمة المرور', border: OutlineInputBorder())),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: FilledButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RiderHomeScreen())),
            child: const Text('حفظ الحساب'),
          )),
        ]),
      ),
    );
  }
}

class RiderHomeScreen extends StatelessWidget {
  const RiderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الراكب')),
      body: Center(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('أنت راكب', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: FilledButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RideRequestScreen())),
            icon: const Icon(Icons.local_taxi), label: const Text('طلب رحلة'),
          )),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: OutlinedButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RideMapScreen())),
            icon: const Icon(Icons.map), label: const Text('خريطة الرحلة'),
          )),
        ]),
      )),
    );
  }
}

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة السائق')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 3,
        itemBuilder: (context, index) => Card(child: ListTile(
          leading: const Icon(Icons.local_taxi),
          title: Text('رحلة رقم ${index + 1} في الجزائر العاصمة'),
          subtitle: const Text('السعر: 500 دج'),
          trailing: FilledButton(onPressed: () {}, child: const Text('قبول')),
        )),
      ),
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة الإدارة')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12,
          children: const [
            _StatCard(icon: Icons.people, title: 'الركاب', value: '0'),
            _StatCard(icon: Icons.drive_eta, title: 'السائقين', value: '0'),
            _StatCard(icon: Icons.local_taxi, title: 'الرحلات', value: '0'),
            _StatCard(icon: Icons.money, title: 'الإيراد', value: '0 دج'),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, size: 32, color: Colors.green),
      const SizedBox(height: 12), Text(title), const SizedBox(height: 8),
      Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    ]),
  ));
}
