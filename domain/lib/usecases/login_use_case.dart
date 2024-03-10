import 'package:domain/domain.dart';
import 'package:domain/entities/user.dart';
import 'package:injectable/injectable.dart';

import 'base/base_use_case.dart';
import 'input/login_input.dart';

@Injectable()
class LoginUseCase extends BaseUseCase<LoginInput, User> {
  final AppRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<User> call(LoginInput input) {
    return _repository.login(input.email, input.password);
  }
}
