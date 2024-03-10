import 'package:domain/entities/server_error_detail.dart';
import 'package:injectable/injectable.dart';

import '../define.dart';
import 'data_mapper.dart';

@Injectable()
class ErrorResponseDetailMapper
    extends DataMapper<ErrorResponseDetail, ServerErrorDetail> {
  @override
  ServerErrorDetail mapToEntity(ErrorResponseDetail data) {
    return ServerErrorDetail(data.message);
  }
}
