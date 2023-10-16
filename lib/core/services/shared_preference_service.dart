import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _sharedPreferences;

  SharedPreferenceService(this._sharedPreferences);

  // ... existing methods ...

  Future<void> setTheme(String theme) async {
    await _sharedPreferences.setString('theme', theme);
  }

  String getTheme() {
    return _sharedPreferences.getString('theme') ?? 'light';  // default to light theme
  }

  Future<void> setLanguage(String languageCode) async {
    await _sharedPreferences.setString('language', languageCode);
  }

  String getLanguage() {
    return _sharedPreferences.getString('language') ?? 'en';  // default to English
  }
}