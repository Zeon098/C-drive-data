// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCbeORxuFIUd0DAsIhX8cl1QcgqXedxNmE',
    appId: '1:913316627963:web:bc9ecb58eb88bcd225f75e',
    messagingSenderId: '913316627963',
    projectId: 'sign-in-f5ed5',
    authDomain: 'sign-in-f5ed5.firebaseapp.com',
    storageBucket: 'sign-in-f5ed5.appspot.com',
    measurementId: 'G-024ENPLWLG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_TrRa2b5pn_mYT3eocXthkrfgK7WeZuc',
    appId: '1:913316627963:android:bc3788dfcce8974625f75e',
    messagingSenderId: '913316627963',
    projectId: 'sign-in-f5ed5',
    storageBucket: 'sign-in-f5ed5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtwgT0YBvH72HarlaK8TQNrIM9S428UjQ',
    appId: '1:913316627963:ios:b5c3eef14a1d126e25f75e',
    messagingSenderId: '913316627963',
    projectId: 'sign-in-f5ed5',
    storageBucket: 'sign-in-f5ed5.appspot.com',
    iosBundleId: 'com.example.flutterSignIn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDtwgT0YBvH72HarlaK8TQNrIM9S428UjQ',
    appId: '1:913316627963:ios:b5c3eef14a1d126e25f75e',
    messagingSenderId: '913316627963',
    projectId: 'sign-in-f5ed5',
    storageBucket: 'sign-in-f5ed5.appspot.com',
    iosBundleId: 'com.example.flutterSignIn',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCbeORxuFIUd0DAsIhX8cl1QcgqXedxNmE',
    appId: '1:913316627963:web:cf5e61743dacd09d25f75e',
    messagingSenderId: '913316627963',
    projectId: 'sign-in-f5ed5',
    authDomain: 'sign-in-f5ed5.firebaseapp.com',
    storageBucket: 'sign-in-f5ed5.appspot.com',
    measurementId: 'G-1HY00R8VG0',
  );

}