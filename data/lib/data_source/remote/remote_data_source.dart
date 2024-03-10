import 'package:data/model/api_response/user_response.dart';
import 'package:data/model/define.dart';
import 'package:domain/domain.dart';
import 'package:domain/entities/user.dart';
import 'package:injectable/injectable.dart';
import 'package:tuple/tuple.dart';

import 'api/services/user_service.dart';

@LazySingleton()
class RemoteDataSource {
  final UserService _userService;
  final UserDataMapper _remoteUserDataMapper;

  RemoteDataSource(this._userService, this._remoteUserDataMapper);

  Future<Tuple2<String?, User>> login(String email, String password) async {
    final response = await _userService.login(email, password);
    if (response.data == null) {
      throw (RemoteException.unexpectedError(Exception('Data not found!')));
    }
    return Tuple2(response.data?.accessToken,
        _remoteUserDataMapper.mapToEntity(response.data!));
  }

  Future<UserResponse?> getUserInfo() async {
    final response = await _userService.getUserInfo();
    return response.data;
  }
}
