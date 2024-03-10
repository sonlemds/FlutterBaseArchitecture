import 'package:domain/entities/user.dart';

abstract class AppRepository {
  Future<bool> saveIsDarkMode(bool isDarkMode);

  bool get isDarkMode;

  Future<User> login(String email, String password);

  bool get isLoggedIn;
}
