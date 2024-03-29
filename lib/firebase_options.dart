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
    apiKey: 'AIzaSyA25rcLi_5bvkvbvSemoiw4V4C5xqXVzGg',
    appId: '1:83398120372:web:87fe9ce809f8e20f2498e1',
    messagingSenderId: '83398120372',
    projectId: 'fireflutter-31158',
    authDomain: 'fireflutter-31158.firebaseapp.com',
    storageBucket: 'fireflutter-31158.appspot.com',
    measurementId: 'G-6L98L4NMPT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBy00QaTmizsHox3DyPG9rO-0jsUoAeBNc',
    appId: '1:83398120372:android:bf103aebfc9fdaf52498e1',
    messagingSenderId: '83398120372',
    projectId: 'fireflutter-31158',
    storageBucket: 'fireflutter-31158.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRPeOUGZs7N75UawSv1vEB8bYAHNUtgZw',
    appId: '1:83398120372:ios:02c0b984e11800fc2498e1',
    messagingSenderId: '83398120372',
    projectId: 'fireflutter-31158',
    storageBucket: 'fireflutter-31158.appspot.com',
    iosBundleId: 'com.example.fire',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRPeOUGZs7N75UawSv1vEB8bYAHNUtgZw',
    appId: '1:83398120372:ios:c1e919219ce399f52498e1',
    messagingSenderId: '83398120372',
    projectId: 'fireflutter-31158',
    storageBucket: 'fireflutter-31158.appspot.com',
    iosBundleId: 'com.example.fire.RunnerTests',
  );
}
