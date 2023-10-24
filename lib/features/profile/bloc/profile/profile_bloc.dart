import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/features/profile/bloc/profile/profile_event.dart';
import 'package:mush_room/features/profile/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {}
}
