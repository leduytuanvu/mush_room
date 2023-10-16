part of 'localization_bloc.dart';

@immutable
abstract class LocalizationEvent {}

class LocalizationUpdated extends LocalizationEvent {
  final Locale locale;

  LocalizationUpdated(this.locale);
}