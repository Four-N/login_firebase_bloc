import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An Know excepsion occurred',
  ]);

  ///สร้าง auth message จาก firebase auth
  factory SignUpWithEmailAndPasswordFailure.formCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
  // ข้อความที่เกี่ยวข้องกับ error
  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknow exception occurred.',
  ]);

  factory LogInWithEmailAndPasswordFailure.formCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const LogInWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const LogInWithEmailAndPasswordFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'weak-password':
        return const LogInWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogInWithGoogleFailure implements Exception {
  const LogInWithGoogleFailure([
    this.message = 'An unknow exception occurred.',
  ]);

  factory LogInWithGoogleFailure.formCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithGoogleFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const LogInWithGoogleFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'weak-password':
        return const LogInWithGoogleFailure(
          'Please enter a stronger password.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  final String message;
}

class LogOutFailure implements Exception {}

//เก็บข้อมูลสำหรับจัดการ user auth
class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  ///ใช้สำหรับเทส
  bool isWeb = kIsWeb;

  /// user cache key
  /// ใช้สำหรับ test
  static const userCacheKey = '__user_cache_ket__';

  ///Stream of [User] เพื่อที่จะส่ง user ปัจจุบันเมื่อ auth state นั้นถูเปลี่ยน
  ///
  ///Emits [User.empty] ถ้า user ไม่ได้ authenticated
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  ///return cached user ปัจจุบัน
  ///Defaluts to [User.empty] ถ้า user ไม่ cached
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  ///สร้าง new user พร้อมกับ provi email และ password
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ///Throws SignUpWithEmailAndPasswordFailure ถ้าเกิด catch
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.formCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  ///sign in with google
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      ///throw LogInWithGoogleFailure ถ้าเกิด catch
      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.formCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  ///sign in with email and password
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ///throw LogInWithEmailAndPasswordFailure ถ้าเกิด catch
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.formCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  ///sign out user ปัจจุบันซึ่งจะส่ง(emit) User.empty จาก user Stream
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);

      ///throw LogOutFailure ถ้าเกิด catch
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  ///Map firebase_auth.User เข้ากับ User
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
