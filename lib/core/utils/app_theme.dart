import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_text_style.dart';

enum AppThemeEnum { light, dark }

class AppTheme {
  static const Color appBarColor = Color(0xFF53B175);

  static final MaterialColor appBarMaterialColor =
      createMaterialColor(appBarColor);

  static MaterialColor createMaterialColor(Color color) {
    List<int> strengths = <int>[
      50,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      900
    ];

    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int strength in strengths) {
      final double ds = 0.5 - (strength / 1000);
      swatch[strength] = Color.fromRGBO(r, g, b, ds);
    }

    return MaterialColor(color.value, swatch);
  }

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: appBarMaterialColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      bodySmall: AppTextStyle.bodyTextStyleH3,
      bodyMedium: AppTextStyle.bodyTextStyleH2,
      bodyLarge: AppTextStyle.bodyTextStyleH1,
      titleSmall: AppTextStyle.titleTextStyleH3,
      titleMedium: AppTextStyle.titleTextStyleH2,
      titleLarge: AppTextStyle.titleTextStyleH1,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      bodySmall: AppTextStyle.bodyTextStyleH3.copyWith(color: Colors.white),
      bodyMedium: AppTextStyle.bodyTextStyleH2.copyWith(color: Colors.white),
      bodyLarge: AppTextStyle.bodyTextStyleH1.copyWith(color: Colors.white),
      titleSmall: AppTextStyle.titleTextStyleH3.copyWith(color: Colors.white),
      titleMedium: AppTextStyle.titleTextStyleH2.copyWith(color: Colors.white),
      titleLarge: AppTextStyle.titleTextStyleH1.copyWith(color: Colors.white),
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
