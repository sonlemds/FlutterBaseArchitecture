import 'package:data/data_source/remote/api/define.dart';
import 'package:data/data_source/remote/api/middleware/basic_auth_interceptor.dart';
import 'package:data/model/define.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class BaseApiService {
  String get baseUrl => ApiConfig.baseUrl();

  late Dio _dio;
  final HttpRequestExceptionMapper _httpRequestExceptionMapper =
      GetIt.instance.get<HttpRequestExceptionMapper>();

  BaseApiService() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: ApiConfig.connectTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConfig.receiveTimeout),
        sendTimeout: const Duration(milliseconds: ApiConfig.sendTimeout),
        baseUrl: baseUrl,
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    _dio.interceptors.add(ConnectivityInterceptor());
  }

  Future<BaseResponse<T>> request<T>({
    required Method method,
    required String path,
    String? contentType,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic body,
    required Decoder<T> decoder,
    ResponseType? responseType,
    int? sendTimeout,
    int? receiveTimeout,
    bool hasTokenAuthentication = true,
    bool hasBasicAuthentication = true,
  }) async {
    try {
      _dio.interceptors.addAll([
        if (hasBasicAuthentication) BasicAuthInterceptor(),
        if (hasTokenAuthentication) AuthInterceptor()
      ]);

      final response = await _request(
        method: method,
        path: path,
        contentType: contentType,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
        responseType: responseType,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
      );

      return BaseResponse.fromJson(
          response.data,
          (json) => decoder(
                (json as Map<String, dynamic>).map(
                  (key, value) => MapEntry(key, value),
                ),
              ));
    } catch (error) {
      throw _httpRequestExceptionMapper.map(error);
    }
  }

  Future<Response<T>> fetch<T>(RequestOptions requestOptions) {
    return _dio.fetch(requestOptions);
  }

  Future<Response<T>> _request<T>({
    required Method method,
    required String path,
    required String? contentType,
    required Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? headers,
    required dynamic body,
    required ResponseType? responseType,
    required int? sendTimeout,
    required int? receiveTimeout,
  }) {
    final options = Options(
      headers: headers,
      contentType: contentType,
      responseType: responseType,
      sendTimeout: Duration(milliseconds: sendTimeout ?? ApiConfig.sendTimeout),
      receiveTimeout:
          Duration(milliseconds: receiveTimeout ?? ApiConfig.receiveTimeout),
    );

    switch (method) {
      case Method.get:
        return _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
        );
      case Method.post:
        return _dio.post(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case Method.patch:
        return _dio.patch(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case Method.put:
        return _dio.put(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case Method.delete:
        return _dio.delete(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
    }
  }
}

enum Method { get, post, put, patch, delete }

typedef Decoder<T> = T Function(Map<String, Object> data);
