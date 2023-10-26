import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is InitializeSplash) {
      await Future.delayed(const Duration(seconds: 0));
      final sharedPreferenceService = injector<SharedPreferenceService>();
      final userEmail = sharedPreferenceService.getEmail();
      if (userEmail.isNotEmpty) {
        final expiry = sharedPreferenceService.getExpiry();
        yield SplashNavigateToBottomBarState();
      } else {
        yield SplashNavigateToLoginState();
      }
    }
  }
}
