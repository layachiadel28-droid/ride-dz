import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'REPLACE_WITH_YOUR_API_KEY',
      appId: 'REPLACE_WITH_YOUR_APP_ID',
      messagingSenderId: 'REPLACE_WITH_YOUR_MESSAGING_SENDER_ID',
      projectId: 'REPLACE_WITH_YOUR_PROJECT_ID',
      storageBucket: 'REPLACE_WITH_YOUR_STORAGE_BUCKET',
      iosBundleId: 'com.example.rideDz',
      androidClientId: 'REPLACE_WITH_YOUR_ANDROID_CLIENT_ID',
      iosClientId: 'REPLACE_WITH_YOUR_IOS_CLIENT_ID',
    );
  }
}
