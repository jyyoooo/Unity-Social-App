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
    apiKey: 'AIzaSyCKk6mLNGhdwu1m-r8AaN3zBisqa_wvR3Y',
    appId: '1:299488500745:web:4e734b40a34daca75d6cd8',
    messagingSenderId: '299488500745',
    projectId: 'unity-social-6483e',
    authDomain: 'unity-social-6483e.firebaseapp.com',
    storageBucket: 'unity-social-6483e.appspot.com',
    measurementId: 'G-CGW5BP6HZ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtZPP6rrkwh7U8A8vKYwb4Rekeu4y_l6M',
    appId: '1:299488500745:android:8ee1fea8aa9e6b4d5d6cd8',
    messagingSenderId: '299488500745',
    projectId: 'unity-social-6483e',
    storageBucket: 'unity-social-6483e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIZAgNoKW82kuGjbTfEcCImzYLudb2LNI',
    appId: '1:299488500745:ios:256d86aa38e75d7f5d6cd8',
    messagingSenderId: '299488500745',
    projectId: 'unity-social-6483e',
    storageBucket: 'unity-social-6483e.appspot.com',
    iosBundleId: 'com.example.unitysocial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCIZAgNoKW82kuGjbTfEcCImzYLudb2LNI',
    appId: '1:299488500745:ios:d12c67db181602115d6cd8',
    messagingSenderId: '299488500745',
    projectId: 'unity-social-6483e',
    storageBucket: 'unity-social-6483e.appspot.com',
    iosBundleId: 'com.example.unitysocial.RunnerTests',
  );
}
