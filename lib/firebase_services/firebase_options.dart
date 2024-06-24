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
    apiKey: 'AIzaSyDgZPP4miBOj5Body43WvmJJxTl_IJ_PCM',
    appId: '1:1048315625904:web:3eac76e6b87e5a64f65675',
    messagingSenderId: '1048315625904',
    projectId: 'shareride-413111',
    authDomain: 'shareride-413111.firebaseapp.com',
    storageBucket: 'shareride-413111.appspot.com',
    measurementId: 'G-96LBTD706K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9VD0S2018H3H6aLJhuOUdsFUPIuqLMvQ',
    appId: '1:1048315625904:android:3c7819da3ff485b4f65675',
    messagingSenderId: '1048315625904',
    projectId: 'shareride-413111',
    storageBucket: 'shareride-413111.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaqASVTrWczs3ENAQkl8ozdRksz2zZ63s',
    appId: '1:1048315625904:ios:6220782e46211eb8f65675',
    messagingSenderId: '1048315625904',
    projectId: 'shareride-413111',
    storageBucket: 'shareride-413111.appspot.com',
    iosBundleId: 'com.example.shareRide',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaqASVTrWczs3ENAQkl8ozdRksz2zZ63s',
    appId: '1:1048315625904:ios:8c99877858ffcde3f65675',
    messagingSenderId: '1048315625904',
    projectId: 'shareride-413111',
    storageBucket: 'shareride-413111.appspot.com',
    iosBundleId: 'com.example.shareRide.RunnerTests',
  );
}
