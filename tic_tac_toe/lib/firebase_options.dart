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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDbFE8bNx66TqeABYCCkfMHZolKG6qB44A',
    appId: '1:865529578888:web:f05544d8b228e3f21d663d',
    messagingSenderId: '865529578888',
    projectId: 'tic-tac-toe-wenhan',
    authDomain: 'tic-tac-toe-wenhan.firebaseapp.com',
    storageBucket: 'tic-tac-toe-wenhan.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxaJ50R2wmvhDCEFCSKbgTXN9uLnmKUSI',
    appId: '1:865529578888:android:5c0ad90dd3024dcc1d663d',
    messagingSenderId: '865529578888',
    projectId: 'tic-tac-toe-wenhan',
    storageBucket: 'tic-tac-toe-wenhan.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbMrU78miPk_YD6gVHtjnfN_lwPuz1x6Q',
    appId: '1:865529578888:ios:cca62bcb3ce68d5f1d663d',
    messagingSenderId: '865529578888',
    projectId: 'tic-tac-toe-wenhan',
    storageBucket: 'tic-tac-toe-wenhan.firebasestorage.app',
    iosBundleId: 'com.example.ticTacToe',
  );
}
