import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _sharedPreferences;

  SharedPreferenceService(this._sharedPreferences);

  Future<void> setTheme(String theme) async {
    await _sharedPreferences.setString(
        AppConstants.sharedPreferenceThemeKey, theme);
  }

  String getTheme() {
    return _sharedPreferences
            .getString(AppConstants.sharedPreferenceThemeKey) ??
        AppThemeEnum.light.toString();
  }

  Future<void> setLanguage(String languageCode) async {
    await _sharedPreferences.setString(
        AppConstants.sharedPreferenceLanguageKey, languageCode);
  }

  String getLanguage() {
    return _sharedPreferences
            .getString(AppConstants.sharedPreferenceLanguageKey) ??
        'vi';
  }

  Future<void> setAccessToken(String token) async {
    await _sharedPreferences.setString(
        AppConstants.sharedPreferenceAccessTokenKey, token);
  }

  String getAccessToken() {
    return _sharedPreferences
            .getString(AppConstants.sharedPreferenceAccessTokenKey) ??
        '';
  }

  Future<void> setRefreshToken(String token) async {
    await _sharedPreferences.setString(
        AppConstants.sharedPreferenceRefreshTokenKey, token);
  }

  String getRefreshToken() {
    return _sharedPreferences
            .getString(AppConstants.sharedPreferenceRefreshTokenKey) ??
        '';
  }

  Future<void> setUser(String userJson) async {
    await _sharedPreferences.setString(
        AppConstants.sharedPreferenceUserKey, userJson);
  }

  String getUser() {
    return _sharedPreferences.getString(AppConstants.sharedPreferenceUserKey) ??
        '';
  }

  Future<void> setEmail(String userJson) async {
    await _sharedPreferences.setString(
        AppConstants.sharedPreferenceEmailKey, userJson);
  }

  String getEmail() {
    return _sharedPreferences
            .getString(AppConstants.sharedPreferenceEmailKey) ??
        '';
  }

  Future<void> setUsername(String userJson) async {
    await _sharedPreferences.setString(
        AppConstants.sharedPreferenceUsernameKey, userJson);
  }

  String getUsername() {
    return _sharedPreferences
            .getString(AppConstants.sharedPreferenceUsernameKey) ??
        '';
  }

  Future<void> setPhone(String userJson) async {
    await _sharedPreferences.setString(
        AppConstants.sharedPreferencePhoneKey, userJson);
  }

  String getPhone() {
    return _sharedPreferences
            .getString(AppConstants.sharedPreferencePhoneKey) ??
        '';
  }

  Future<void> setExpiry(int expiry) async {
    await _sharedPreferences.setInt(
        AppConstants.sharedPreferenceExpiryKey, expiry);
  }

  int getExpiry() {
    return _sharedPreferences.getInt(AppConstants.sharedPreferenceExpiryKey) ??
        0;
  }

  void clearUser() async {
    _sharedPreferences.remove(AppConstants.sharedPreferenceUserKey);
  }

  void clearTokens() async {
    _sharedPreferences.remove(AppConstants.sharedPreferenceAccessTokenKey);
    _sharedPreferences.remove(AppConstants.sharedPreferenceRefreshTokenKey);
  }
}
