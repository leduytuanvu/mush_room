import 'package:flutter/material.dart';

class AppConstants {
  // SharedPreferences keys
  static const String sharedPreferenceThemeKey = 'theme';
  static const String sharedPreferenceLanguageKey = 'language';

  static const String sharedPreferenceAccessTokenKey = 'access_token';
  static const String sharedPreferenceRefreshTokenKey = 'refresh_token';

  // Themes
  static const Color lightPrimaryColor = Colors.blue;
  static const Color darkPrimaryColor = Colors.blueGrey;

  // Fonts
  static const double defaultFontSize = 14.0;

  // Padding/Margin
  static const double defaultPadding = 16.0;
}
