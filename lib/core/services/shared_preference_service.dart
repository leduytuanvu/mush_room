import 'package:mush_room/core/utils/app_localizations.dart';
import 'package:mush_room/core/utils/app_themes.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _sharedPreferences;

  SharedPreferenceService(this._sharedPreferences);

  Future<void> setTheme(String theme) async {
    await _sharedPreferences.setString(AppConstants.sharedPreferenceThemeKey, theme);
  }

  String getTheme() {
    return _sharedPreferences.getString(AppConstants.sharedPreferenceThemeKey) ?? AppThemeEnum.light.toString();
  }

  Future<void> setLanguage(String languageCode) async {
    await _sharedPreferences.setString(AppConstants.sharedPreferenceLanguageKey, languageCode);
  }

  String getLanguage() {
    return _sharedPreferences.getString(AppConstants.sharedPreferenceLanguageKey) ?? 'vi';
  }

  Future<void> setAccessToken(String token) async {
    await _sharedPreferences.setString(AppConstants.sharedPreferenceAccessTokenKey, token);
  }

  String getAccessToken() {
    return _sharedPreferences.getString(AppConstants.sharedPreferenceAccessTokenKey) ?? '';
  }

  Future<void> setRefreshToken(String token) async {
    await _sharedPreferences.setString(AppConstants.sharedPreferenceRefreshTokenKey, token);
  }

  String getRefreshToken() {
    return _sharedPreferences.getString(AppConstants.sharedPreferenceRefreshTokenKey) ?? '';
  }

  void clearTokens() async {
    _sharedPreferences.remove(AppConstants.sharedPreferenceAccessTokenKey);
    _sharedPreferences.remove(AppConstants.sharedPreferenceRefreshTokenKey);
  }
}