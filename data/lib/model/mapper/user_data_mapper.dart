import 'package:data/model/define.dart';
import 'package:domain/entities/user.dart';
import 'package:injectable/injectable.dart';

import 'data_mapper.dart';

@Injectable()
class UserDataMapper extends DataMapper<LoginResponse, User> {
  @override
  User mapToEntity(LoginResponse data) {
    return User(1, 'name');
  }
}
