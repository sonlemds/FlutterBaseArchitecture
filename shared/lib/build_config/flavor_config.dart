enum Flavor {
  dev,
  stg,
  prod,
}

extension FlavorExt on Flavor {
  String getName() {
    switch (this) {
      case Flavor.dev:
        return 'Develop';
      case Flavor.stg:
        return 'Staging';
      case Flavor.prod:
        return 'Production';
    }
  }

  String getBaseUrl() {
    switch (this) {
      case Flavor.dev:
        return 'https://api.rental-dev.madlab.tech';
      case Flavor.stg:
        return 'https://wallpapernew.net';
      case Flavor.prod:
        return 'https://wallpapernew.net';
    }
  }
}

class FlavorValues {
  final String baseUrl;

  //Add other flavor specific values, e.g database name

  FlavorValues({
    required this.baseUrl,
  });
}

class FlavorConfig {
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;

  static const envKey = 'env';

  static Flavor flavor = Flavor.values
      .byName(const String.fromEnvironment(envKey, defaultValue: 'dev'));

  static void init() {
    FlavorConfig();
  }

  factory FlavorConfig() {
    _instance ??= FlavorConfig._internal(
        flavor.getName(), FlavorValues(baseUrl: flavor.getBaseUrl()));

    return _instance!;
  }

  FlavorConfig._internal(this.name, this.values);

  static FlavorConfig? get instance => _instance;

  static bool isProduction() => flavor == Flavor.prod;

  static bool isDevelopment() => flavor == Flavor.dev;

  static bool isStaging() => flavor == Flavor.stg;
}
