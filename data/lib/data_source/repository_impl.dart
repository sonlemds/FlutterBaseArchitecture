import 'package:domain/domain.dart';
import 'package:domain/entities/user.dart';
import 'package:injectable/injectable.dart';

import 'local/define.dart';
import 'remote/remote_data_source.dart';

@LazySingleton(as: AppRepository)
class RepositoryImpl extends AppRepository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  bool get isDarkMode => _localDataSource.isDarkMode;

  @override
  Future<bool> saveIsDarkMode(bool isDarkMode) {
    return _localDataSource.saveIsDarkMode(isDarkMode);
  }

  @override
  bool get isLoggedIn => _localDataSource.isLoggedIn;

  Future<List<Object>> _saveLocalData(String token) async {
    return Future.wait([
      _localDataSource.saveAccessToken(token),
      _localDataSource.saveIsLoggedIn(true),
    ]);
  }

  @override
  Future<User> login(String email, String password) async {
    final result = await _remoteDataSource.login(email, password);
    if ((result.item1 ?? '').isNotEmpty) {
      await _saveLocalData(result.item1!);
    }
    return result.item2;
  }
}
