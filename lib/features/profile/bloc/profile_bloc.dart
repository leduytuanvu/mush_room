import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/utils/app_validation.dart';
import 'package:mush_room/features/profile/bloc/profile_event.dart';
import 'package:mush_room/features/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  ProfileBloc() : super(ProfileInitialState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ShowLogoutProfileEvent) {
      try {
        yield ShowLogoutProfileState();
      } catch (error) {
        yield ProfileErrorState();
      }
    } else if (event is ResetProfileEvent){
      try {
        yield ProfileInitialState();
      } catch(error) {
        yield ProfileErrorState();
      }
    }
  }
}