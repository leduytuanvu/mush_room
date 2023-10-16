import 'config.dart';

class DevConfig implements Config {
  @override
  String get apiBaseUrl => 'https://stag-api.example.com';

  @override
  String get apiKey => 'your-stag-api-key-here';

  @override
  int get connectTimeout => 7000;

  @override
  String get dbName => 'stag_database.db';

  @override
  String get logLevel => 'DEV';

  @override
  int get receiveTimeout => 4000;
}