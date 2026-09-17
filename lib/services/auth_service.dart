import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> login(String email, String password) async {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;
    if (user == null) throw Exception('User creation failed');

    await user.updateDisplayName(name.trim());

    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': name.trim(),
      'email': email.trim(),
      'role': role,
      'isAvailable': false,
      'isApproved': role == 'rider',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return credential;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
