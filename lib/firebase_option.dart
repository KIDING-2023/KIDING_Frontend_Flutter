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
    apiKey: 'AIzaSyDRsXQuBXu7YmQkgxNjhT6EqOYXfvCIoTg',
    appId: '1:1076691090743:web:fc654a79564c347c2aaeb2',
    messagingSenderId: '1076691090743',
    projectId: 'kiding-4a264',
    authDomain: 'kiding-4a264.firebaseapp.com',
    storageBucket: 'kiding-4a264.appspot.com',
    measurementId: 'G-LR5QBWYC41',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJp0VSV5HFPC9cc9J1cXTjIhi_qwo1UV4',
    appId: '1:1076691090743:android:53d9ae11b2d5b4d92aaeb2',
    messagingSenderId: '1076691090743',
    projectId: 'kiding-4a264',
    storageBucket: 'kiding-4a264.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSXy18JSGVJ2qbH3wHV8mlKMqxxooZ4KQ',
    appId: '1:1076691090743:ios:34cc85a443335aa52aaeb2',
    messagingSenderId: '1076691090743',
    projectId: 'kiding-4a264',
    storageBucket: 'kiding-4a264.appspot.com',
    iosBundleId: 'com.example.kiding',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCSXy18JSGVJ2qbH3wHV8mlKMqxxooZ4KQ',
    appId: '1:1076691090743:ios:34cc85a443335aa52aaeb2',
    messagingSenderId: '1076691090743',
    projectId: 'kiding-4a264',
    storageBucket: 'kiding-4a264.appspot.com',
    iosBundleId: 'com.example.kiding',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDRsXQuBXu7YmQkgxNjhT6EqOYXfvCIoTg',
    appId: '1:1076691090743:web:8b1bd608cbfd8e0f2aaeb2',
    messagingSenderId: '1076691090743',
    projectId: 'kiding-4a264',
    authDomain: 'kiding-4a264.firebaseapp.com',
    storageBucket: 'kiding-4a264.appspot.com',
    measurementId: 'G-Q5G8KVF7E8',
  );
}
