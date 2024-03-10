import 'package:data/data_source/remote/api/define.dart';
import 'package:data/model/api_response/refresh_token_response.dart';
import 'package:data/model/define.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class RefreshTokenService extends BaseApiService {
  Future<BaseResponse<RefreshTokenResponse>> refreshToken() async {
    return request(
      method: Method.post,
      path: EndPoint.refreshToken.endPoint,
      contentType: Headers.formUrlEncodedContentType,
      body: {'refresh_token': refreshToken, 'grant_type': 'refresh_token'},
      hasTokenAuthentication: false,
      decoder: RefreshTokenResponse.fromJson,
    );
  }
}
