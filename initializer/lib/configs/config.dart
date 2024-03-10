import 'package:async/async.dart';
import 'package:shared/build_config/flavor_config.dart';

abstract class Config {
  final AsyncMemoizer<void> _asyncMemoizer = AsyncMemoizer<void>();

  Future<void> config();

  Future<void> init() => _asyncMemoizer.runOnce(config);
}

abstract class ApplicationConfig extends Config {}

class AppInitializer {
  AppInitializer(this._applicationConfig);

  final ApplicationConfig _applicationConfig;

  Future<void> init() async {
    FlavorConfig.init();
    await _applicationConfig.init();
  }
}
