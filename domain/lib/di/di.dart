import 'package:data/di/di.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDomainInjection() async {
  await configureDataDependencies();
  getIt.init();
}
