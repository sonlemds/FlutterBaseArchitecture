import 'package:app_name/src/config/config.dart';
import 'package:flutter/material.dart';
import 'package:initializer/configs/config.dart';

import 'src/app.dart';
import 'src/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer(AppConfig.getInstance()).init();
  await configureDependencies();

  runApp(const MyApp());
}
