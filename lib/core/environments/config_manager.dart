import 'config.dart';
import 'dev_config.dart';
import 'stag_config.dart';
import 'prod_config.dart';

enum Environment { dev, stag, prod }

class ConfigManager {
  static Config? _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = DevConfig();
        break;
      case Environment.stag:
        _config = StagConfig();
        break;
      case Environment.prod:
        _config = ProdConfig();
        break;
    }
  }

  static Config get config {
    if (_config == null) {
      throw ConfigNotInitializedException();
    }
    return _config!;
  }
}

class ConfigNotInitializedException implements Exception {
  @override
  String toString() {
    return 'ConfigManager has not been initialized. Call ConfigManager.setEnvironment first.';
  }
}



