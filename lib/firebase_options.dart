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
    apiKey: 'AIzaSyBdG6aAKAwyqgzzjAVJnNqEhdgRrq17zhc',
    appId: '1:763149383100:web:63811e2c40d8c6fcb267b9',
    messagingSenderId: '763149383100',
    projectId: 'bloc-flutter-login-6588e',
    authDomain: 'bloc-flutter-login-6588e.firebaseapp.com',
    storageBucket: 'bloc-flutter-login-6588e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBr3XKrl9LaZOgedl-j9HMwY-TnbQAdxAU',
    appId: '1:763149383100:android:966c3b78fe0dd920b267b9',
    messagingSenderId: '763149383100',
    projectId: 'bloc-flutter-login-6588e',
    storageBucket: 'bloc-flutter-login-6588e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCb88iYDBC8XuCtIMj9E-Om-EqlaDsi2Xk',
    appId: '1:763149383100:ios:304f124e8468756ab267b9',
    messagingSenderId: '763149383100',
    projectId: 'bloc-flutter-login-6588e',
    storageBucket: 'bloc-flutter-login-6588e.appspot.com',
    iosBundleId: 'com.example.loginFirebaseBloc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCb88iYDBC8XuCtIMj9E-Om-EqlaDsi2Xk',
    appId: '1:763149383100:ios:560570410528d9dab267b9',
    messagingSenderId: '763149383100',
    projectId: 'bloc-flutter-login-6588e',
    storageBucket: 'bloc-flutter-login-6588e.appspot.com',
    iosBundleId: 'com.example.loginFirebaseBloc.RunnerTests',
  );
}
