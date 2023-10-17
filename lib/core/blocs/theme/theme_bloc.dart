import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferenceService _sharedPreferenceService;

  ThemeBloc(this._sharedPreferenceService) : super(
      _sharedPreferenceService.getTheme() == AppThemeEnum.dark.toString()
          ? ThemeState(AppTheme.darkTheme)
          : ThemeState(AppTheme.lightTheme)
  );

  @override
  Stream<ThemeState> mapEventToState(
      ThemeEvent event,
      ) async* {
    if (event is ThemeLightModeEnabled) {
      yield ThemeState(AppTheme.lightTheme);
      _sharedPreferenceService.setTheme(AppThemeEnum.light.toString());
    } else if (event is ThemeDarkModeEnabled) {
      yield ThemeState(AppTheme.darkTheme);
      _sharedPreferenceService.setTheme(AppThemeEnum.dark.toString());
    }
  }
}
