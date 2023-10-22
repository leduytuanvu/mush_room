import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/models/user/user_model.dart';
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
      final userJsonTmp = sharedPreferenceService.getUser();
      if (userJsonTmp != null && userJsonTmp.isNotEmpty) {
        Map<String, dynamic> userMap = jsonDecode(userJsonTmp);
        UserModel user = UserModel.fromJson(userMap);
        yield SplashNavigateToBottomBarState();
      } else {
        yield SplashNavigateToLoginState();
      }
    }
  }
}
