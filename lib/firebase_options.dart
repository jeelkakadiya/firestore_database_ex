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
    apiKey: 'AIzaSyAWiE22M4BCAzWsRZ4hyqSC3GUM1wPEe9M',
    appId: '1:769030780887:android:d34f80ee8cdbda335b3d92',
    messagingSenderId: '769030780887',
    projectId: 'notepro-19387',
    databaseURL: 'https://notepro-19387-default-rtdb.firebaseio.com',
    storageBucket: 'notepro-19387.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCa44BWMQE-PWeSjg8FZCe3gOC4-YjzxOU',
    appId: '1:769030780887:ios:e7459c18cf470fbb5b3d92',
    messagingSenderId: '769030780887',
    projectId: 'notepro-19387',
    databaseURL: 'https://notepro-19387-default-rtdb.firebaseio.com',
    storageBucket: 'notepro-19387.appspot.com',
    iosClientId: '769030780887-b4pce6lrokn60v3sautf4savmi5o8nhg.apps.googleusercontent.com',
    iosBundleId: 'com.example.newtask',
  );
}
