import 'package:flutter/material.dart';

class AppConstants {
  // SharedPreferences keys
  static const String sharedPreferenceThemeKey = 'theme';
  static const String sharedPreferenceLanguageKey = 'language';
  static const String sharedPreferenceUserKey = 'user';
  static const String sharedPreferenceExpiryKey = 'user';
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
}
