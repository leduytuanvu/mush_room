import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_text_style.dart';

enum AppThemeEnum {
  light,
  dark
}

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme:  TextTheme(
      bodySmall: AppTextStyle.bodyTextStyleH3(),
      bodyMedium: AppTextStyle.bodyTextStyleH2(),
      bodyLarge: AppTextStyle.bodyTextStyleH1(),

      titleSmall: AppTextStyle.titleTextStyleH3(),
      titleMedium: AppTextStyle.titleTextStyleH2(),
      titleLarge: AppTextStyle.titleTextStyleH1(),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      bodySmall: AppTextStyle.bodyTextStyleH3(color: Colors.white),
      bodyMedium: AppTextStyle.bodyTextStyleH2(color: Colors.white),
      bodyLarge: AppTextStyle.bodyTextStyleH1(color: Colors.white),

      titleSmall: AppTextStyle.titleTextStyleH3(color: Colors.white),
      titleMedium: AppTextStyle.titleTextStyleH2(color: Colors.white),
      titleLarge: AppTextStyle.titleTextStyleH1(color: Colors.white),
    ),
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
