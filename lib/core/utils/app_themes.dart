// lib/core/utils/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

extension ThemeModeExtension on ThemeMode {
  ThemeData get data {
    switch (this) {
      case ThemeMode.dark:
        return AppTheme.darkTheme;
      case ThemeMode.light:
      case ThemeMode.system:
      default:
        return AppTheme.lightTheme;
    }
  }
}
