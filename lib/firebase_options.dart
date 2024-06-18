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
    apiKey: 'AIzaSyBSgEaQPPr_LhQUrC7KFXxDemQ72h8xROI',
    appId: '1:318506649151:web:0f04e2b5b7322965725a8a',
    messagingSenderId: '318506649151',
    projectId: 'fakeflix-f4b1e',
    authDomain: 'fakeflix-f4b1e.firebaseapp.com',
    storageBucket: 'fakeflix-f4b1e.appspot.com',
    measurementId: 'G-GCSMTPCVJZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2JiIRdNpwXSF0ueNXKCsg_mwNAbAhTBc',
    appId: '1:318506649151:android:047579a0f8c5c8b6725a8a',
    messagingSenderId: '318506649151',
    projectId: 'fakeflix-f4b1e',
    storageBucket: 'fakeflix-f4b1e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMkVkzidQ7EwB4PILTS4RcBPt4IgBG5tY',
    appId: '1:318506649151:ios:607e61f39a91ef8e725a8a',
    messagingSenderId: '318506649151',
    projectId: 'fakeflix-f4b1e',
    storageBucket: 'fakeflix-f4b1e.appspot.com',
    iosBundleId: 'com.example.fakeflix',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMkVkzidQ7EwB4PILTS4RcBPt4IgBG5tY',
    appId: '1:318506649151:ios:607e61f39a91ef8e725a8a',
    messagingSenderId: '318506649151',
    projectId: 'fakeflix-f4b1e',
    storageBucket: 'fakeflix-f4b1e.appspot.com',
    iosBundleId: 'com.example.fakeflix',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBSgEaQPPr_LhQUrC7KFXxDemQ72h8xROI',
    appId: '1:318506649151:web:603f77a8fdd3c042725a8a',
    messagingSenderId: '318506649151',
    projectId: 'fakeflix-f4b1e',
    authDomain: 'fakeflix-f4b1e.firebaseapp.com',
    storageBucket: 'fakeflix-f4b1e.appspot.com',
    measurementId: 'G-LG35JS0KR9',
  );
}