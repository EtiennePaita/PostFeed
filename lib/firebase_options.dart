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
    apiKey: 'AIzaSyDr5assRB3mT9a9SP0r6mZB1rcKxe3BXl8',
    appId: '1:274834559762:web:78e8e4252232c4134999cb',
    messagingSenderId: '274834559762',
    projectId: 'postfeed-b1dea',
    authDomain: 'postfeed-b1dea.firebaseapp.com',
    storageBucket: 'postfeed-b1dea.appspot.com',
    measurementId: 'G-HW37DPGG0N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCN3YdLgzn7Lu2-zx9xSemJqjkZ4dCZ3FE',
    appId: '1:274834559762:android:3464896e3d20af624999cb',
    messagingSenderId: '274834559762',
    projectId: 'postfeed-b1dea',
    storageBucket: 'postfeed-b1dea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvLmGW__PjE4D_mdY4RJkTZUgcz09pInQ',
    appId: '1:274834559762:ios:990a7955819af8a24999cb',
    messagingSenderId: '274834559762',
    projectId: 'postfeed-b1dea',
    storageBucket: 'postfeed-b1dea.appspot.com',
    androidClientId: '274834559762-rp3dra7v7j39htarct0u5pqj4pqlp2ua.apps.googleusercontent.com',
    iosClientId: '274834559762-ngcdc26eskpna28mi4ct7ggg5j6q677v.apps.googleusercontent.com',
    iosBundleId: 'com.ep.postFeed',
  );
}
