import 'dart:ui';

import 'package:domain/domain.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/usecases/input/login_input.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared/base/base.dart';
import 'package:shared/extensions/define.dart';

@injectable
class SignInBloc extends BaseBloc {
  final LoginUseCase _loginUseCase;

  /// Input
  late void Function(String) funcEmailChanged;
  late void Function(String) funcPasswordChanged;
  late VoidCallback funcSubmit;

  /// Output
  late Stream<String?> streamError;
  late Stream<bool> streamIsButtonLoginEnable;
  late Stream<bool> streamLoginSuccess;

  SignInBloc(this._loginUseCase) {
    final emailController = BehaviorSubject.seeded("")..disposeBy(disposeBag);
    final passwordController = BehaviorSubject.seeded("")
      ..disposeBy(disposeBag);
    final submitController = PublishSubject<void>()..disposeBy(disposeBag);

    funcEmailChanged = (value) => emailController.add(value);
    funcPasswordChanged = passwordController.add;
    funcSubmit = () => submitController.add(null);

    final Stream<String?> validationError = submitController.stream.map((_) {
      // demo validation
      if (passwordController.value.length < 8 ||
          passwordController.value.length > 20) {
        return "Wrong password format!";
      }
      return null;
    });

    streamIsButtonLoginEnable = Rx.combineLatest2(
        emailController.stream,
        passwordController.stream,
        (String email, String password) =>
            email.isNotEmpty &&
            password.isNotEmpty &&
            (passwordController.value.length >= 8 &&
                passwordController.value.length <= 20)).share();

    streamError = Rx.merge([
      validationError,
      streamIsButtonLoginEnable.mapTo(null),
    ]);

    streamLoginSuccess = validationError.flatMap((String? error) {
      if (error == null) {
        return _login(emailController.value, passwordController.value)
            .map((value) => true);
      } else {
        return const Stream.empty();
      }
    });
  }

  Stream<User> _login(String email, String password) => executeFuture(
        _loginUseCase.call(LoginInput(email, password)),
      );
}
