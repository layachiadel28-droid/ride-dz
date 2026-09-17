import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  String _role = 'rider';
  bool _loading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      await _authService.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        role: _role,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
      );
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل إنشاء الحساب: $error')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'الاسم الكامل', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().length < 2) ? 'أدخل الاسم' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'الإيميل', border: OutlineInputBorder()),
              validator: (v) => (v == null || !v.contains('@')) ? 'أدخل إيميل صحيح' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'كلمة المرور', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.length < 6) ? 'أقل 6 أحرف' : null,
            ),
            const SizedBox(height: 16),
            RadioListTile<String>(
              value: 'rider',
              groupValue: _role,
              title: const Text('راكب'),
              onChanged: (value) => setState(() => _role = value ?? 'rider'),
            ),
            RadioListTile<String>(
              value: 'driver',
              groupValue: _role,
              title: const Text('سائق'),
              onChanged: (value) => setState(() => _role = value ?? 'driver'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _loading ? null : _register,
                child: _loading ? const CircularProgressIndicator() : const Text('إنشاء الحساب'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
