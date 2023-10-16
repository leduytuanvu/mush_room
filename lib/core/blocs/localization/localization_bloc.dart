import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final SharedPreferenceService _sharedPreferenceService;

  LocalizationBloc(this._sharedPreferenceService)
      : super(LocalizationState(Locale(_sharedPreferenceService.getLanguage())));

  @override
  Stream<LocalizationState> mapEventToState(LocalizationEvent event) async* {
    if (event is LocalizationUpdated) {
      yield LocalizationState(event.locale);
      _sharedPreferenceService.setLanguage(event.locale.languageCode);
    }
  }
}