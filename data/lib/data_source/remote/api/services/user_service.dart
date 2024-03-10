import 'package:data/data_source/remote/api/define.dart';
import 'package:data/model/api_response/user_response.dart';
import 'package:data/model/define.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UserService extends BaseApiService {
  Future<BaseResponse<LoginResponse>> login(
      String email, String password) async {
    return request(
      method: Method.post,
      path: EndPoint.signIn.endPoint,
      body: {
        'email': email,
        'password': password,
      },
      hasTokenAuthentication: false,
      decoder: LoginResponse.fromJson,
    );
  }

  Future<BaseResponse<UserResponse>> getUserInfo() async {
    return request(
      method: Method.get,
      path: EndPoint.userProfile.endPoint,
      body: {},
      hasTokenAuthentication: true,
      decoder: UserResponse.fromJson,
    );
  }
}
