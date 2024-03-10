import 'package:domain/di/di.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mini_app/mini_app.dart';

import 'di.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await configureDomainInjection();
  await configureMiniAppDependencies();
  getIt.init();
}
