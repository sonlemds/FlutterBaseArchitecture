import 'package:data/model/define.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
@Injectable()
class HttpRequestExceptionMapper extends ExceptionMapper<RemoteException> {
  final ErrorResponseMapper _errorResponseMapper;

  HttpRequestExceptionMapper(this._errorResponseMapper);

  @override
  RemoteException map(Object? exception) {
    if (exception is DioException) {
      if (exception.error is RemoteException) {
        return exception.error as RemoteException;
      }

      switch (exception.type) {
        case DioExceptionType.cancel:
          return const RemoteException.cancellationError();
        case DioExceptionType.sendTimeout:
          return const RemoteException.noInternet();
        case DioExceptionType.receiveTimeout:
          return const RemoteException.timeoutError();
        case DioExceptionType.connectionTimeout:
          return const RemoteException.timeoutError();
        case DioExceptionType.badCertificate:
        case DioExceptionType.badResponse:
          if (exception.response?.data != null) {
            final errorResponse =
                ErrorResponse.fromJson(exception.response!.data!);
            return RemoteException.serverError(
              exception.response!.statusCode,
              _errorResponseMapper.mapToEntity(errorResponse),
              errorResponse.message,
            );
          } else {
            return RemoteException.httpError(exception.response!.statusCode);
          }
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
      }
    }

    return RemoteException.unexpectedError(exception is Exception
        ? exception
        : Exception(exception?.toString() ?? "Unexpected error"));
  }
}
