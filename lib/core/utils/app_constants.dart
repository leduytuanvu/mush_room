import 'package:flutter/material.dart';
import 'package:mush_room/core/environments/config_manager.dart';

class AppConstants {
  // SharedPreferences keys
  static const String sharedPreferenceThemeKey = 'theme';
  static const String sharedPreferenceLanguageKey = 'language';
  static const String sharedPreferenceUserKey = 'user';
  static const String sharedPreferenceEmailKey = 'email';
  static const String sharedPreferenceUsernameKey = 'username';
  static const String sharedPreferencePhoneKey = 'phone';
  static const String sharedPreferenceExpiryKey = 'expiry';
  static const String sharedPreferenceAccessTokenKey = 'access_token';
  static const String sharedPreferenceRefreshTokenKey = 'refresh_token';

  // Themes
  static const Color lightPrimaryColor = Colors.blue;
  static const Color darkPrimaryColor = Colors.blueGrey;

  static const Color appBarColor = Color(0xFF53B175);
  static const Color buttonColor = Color(0xFF53B175);
  static const Color linkColor = Color(0xFF53B175);

  // Fonts
  static const double defaultFontSize = 14.0;

  // Padding/Margin
  static const double defaultPadding = 16.0;

  static const String appName = 'MUSH ROOM';

  // Endpoints
  static String apiLoginUrl = '${ConfigManager.config.apiBaseUrl}/iot/signIn';
  static String apiRegisterUrl =
      '${ConfigManager.config.apiBaseUrl}/iot/signUp';
  static String apiForgotPasswordUrl =
      '${ConfigManager.config.apiBaseUrl}/iot/forgotPassword';
  static String apiConfirmForgotPasswordUrl =
      '${ConfigManager.config.apiBaseUrl}/iot/confirmForgotPassword';
  static String apiRefreshTokenUrl =
      '${ConfigManager.config.apiBaseUrl}/iot/refreshToken';
  static String apiUpdatePasswordUrl =
      '${ConfigManager.config.apiBaseUrl}/iot/changePassword';
  static String apiDeleteAccountUrl =
      '${ConfigManager.config.apiBaseUrl}/iot/user';
  static String apiUpdateUserUrl =
      '${ConfigManager.config.apiBaseUrl}/iot/user';
  static String apiGetInforUser = '${ConfigManager.config.apiBaseUrl}/iot/user';
}
