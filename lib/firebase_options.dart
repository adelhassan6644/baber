// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBdwndJ7u4a3PZvPCQXFbPQX5yvKKT6ZxE',
    appId: '1:543303823124:web:e9376840c3c03971ef1c01',
    messagingSenderId: '543303823124',
    projectId: 'baber-27e2c',
    authDomain: 'baber-27e2c.firebaseapp.com',
    storageBucket: 'baber-27e2c.appspot.com',
    measurementId: 'G-Q6LJ812SM6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChYQXbF9BBS-fAiBM_mhO9-uUEmg_WWzo',
    appId: '1:543303823124:android:230a7a9b52a77232ef1c01',
    messagingSenderId: '543303823124',
    projectId: 'baber-27e2c',
    storageBucket: 'baber-27e2c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBv4IWZyPZCHfRZ5Kxk0KhDLhekDbTH_bM',
    appId: '1:543303823124:ios:331c3f76e0d0cb3cef1c01',
    messagingSenderId: '543303823124',
    projectId: 'baber-27e2c',
    storageBucket: 'baber-27e2c.appspot.com',
    androidClientId: '543303823124-ua2qm5pido9m8l6d7r639r51sco6rvpq.apps.googleusercontent.com',
    iosClientId: '543303823124-csosei9d644ap6vef03c88ddv067n007.apps.googleusercontent.com',
    iosBundleId: 'com.example.baber',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBv4IWZyPZCHfRZ5Kxk0KhDLhekDbTH_bM',
    appId: '1:543303823124:ios:331c3f76e0d0cb3cef1c01',
    messagingSenderId: '543303823124',
    projectId: 'baber-27e2c',
    storageBucket: 'baber-27e2c.appspot.com',
    androidClientId: '543303823124-ua2qm5pido9m8l6d7r639r51sco6rvpq.apps.googleusercontent.com',
    iosClientId: '543303823124-csosei9d644ap6vef03c88ddv067n007.apps.googleusercontent.com',
    iosBundleId: 'com.example.baber',
  );
}
