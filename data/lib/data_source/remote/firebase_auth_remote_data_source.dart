import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'firebase/firebase_auth_service.dart';

@LazySingleton()
class FirebaseAuthRemoteDataSource {
  FirebaseAuthService authService;

  FirebaseAuthRemoteDataSource({required this.authService});

  Future<User?> createUser(
      {required String name,
      required String email,
      required String password}) async {
    var response = await authService.createUser(
        email: email, password: password, name: name);
    return response;
  }

  Future<User> updateUserImage({required String image}) async {
    var response = await authService.updateUserPhoto(image);
    return response;
  }

  Future<void> resetPassword({required String email}) async {
    await authService.resetPassword(email: email);
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    var response = await authService.signInUserWithEmailAndPassword(
        email: email, password: password);
    return response;
  }

  Future<User?> signInWithGoogle() async {
    var response = await authService.signInWithGoogle();
    return response;
  }

  Future<void> deleteAccount() async {
    await authService.deleteAccount();
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

  Future<User> updateUserDisplayName({required String name}) async {
    var response = await authService.updateUserDisplayName(name);
    return response;
  }

  Future<User> changePassword(
      {required String password,
      required String newPassword,
      required String email}) async {
    var response = await authService.changePassword(
        password: password, newPassword: newPassword, email: email);
    return response;
  }
}
