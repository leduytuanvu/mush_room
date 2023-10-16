part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeLightModeEnabled extends ThemeEvent {}

class ThemeDarkModeEnabled extends ThemeEvent {}