import 'dart:async';
import 'dart:io';

import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 60));
      await authResult.user!.updateDisplayName(name);
      return authResult.user!;
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<User?> createUserWithPhoneNumber({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval of OTP completed (not needed for this use case)
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
        },
        codeSent: (String verificationId, int? resendToken) {
          // Handle OTP code sent to the phone
          // Store verificationId for later use (e.g., in a text field)
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
    return null; // Return null here because the authentication process continues asynchronously
  }

  Future<User?> signInUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 60));
      return authResult.user!;
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<User?> signInUserWithPhoneNumber(
      {required String verificationId, required String smsCode}) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final authResult = await _firebaseAuth
          .signInWithCredential(credential)
          .timeout(const Duration(seconds: 60));
      return authResult.user!;
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<User> updateUserPhoto(String photo) async {
    try {
      await _firebaseAuth.currentUser!
          .updatePhotoURL(photo)
          .timeout(const Duration(seconds: 60));
      return _firebaseAuth.currentUser!;
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<User> updateUserDisplayName(String name) async {
    try {
      await _firebaseAuth.currentUser!
          .updateDisplayName(name)
          .timeout(const Duration(seconds: 60));
      return _firebaseAuth.currentUser!;
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth
          .sendPasswordResetEmail(email: email)
          .timeout(const Duration(seconds: 60));
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final authResult = await _firebaseAuth
          .signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            ),
          )
          .timeout(const Duration(seconds: 60));
      return authResult.user!;
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _firebaseAuth.currentUser!
          .delete()
          .timeout(const Duration(seconds: 60));
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut().timeout(const Duration(seconds: 60));
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }

  Future<User> changePassword(
      {required String password,
      required String newPassword,
      required String email}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
      return _firebaseAuth.currentUser!;
    } on FirebaseAuthException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (e) {
      throw RemoteException.unexpectedError(e);
    }
  }
}
