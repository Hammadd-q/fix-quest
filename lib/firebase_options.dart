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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYSPr4UGhVwQysk8coBomu3z13YG8d1gM',
    appId: '1:98997137479:android:140f906f823aeba9818162',
    messagingSenderId: '98997137479',
    projectId: 'alison-grimaldi',
    storageBucket: 'alison-grimaldi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxAy2aqyx8MBPXXT1-w697Iu_l1jTBvLs',
    appId: '1:98997137479:ios:149c582d03a00b7b818162',
    messagingSenderId: '98997137479',
    projectId: 'alison-grimaldi',
    storageBucket: 'alison-grimaldi.appspot.com',
    androidClientId: '98997137479-lad3i5paufaodo0bs0vk5lslsjas70s7.apps.googleusercontent.com',
    iosClientId: '98997137479-6rodlmj0ustua7mq6pkkk9ql8thlka5h.apps.googleusercontent.com',
    iosBundleId: 'com.alison.hipquest',
  );
}