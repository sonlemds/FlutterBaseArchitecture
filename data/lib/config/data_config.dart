// import 'package:data/repository/remote/firebase/remote_config/firebase_remote_config.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:initializer/configs/config.dart';

class DataConfig extends Config {
  DataConfig._();

  factory DataConfig.getInstance() {
    return _instance;
  }

  static final DataConfig _instance = DataConfig._();

  @override
  Future<void> config() async {
    await EncryptedSharedPreferences.initialize('1234123412341234');
    // FirebaseRemoteConfigService().initialize();
  }
}
