import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/features/auth/register/bloc/register_event.dart';
import 'package:mush_room/features/auth/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState(email: '', password: ''));

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // Handle events that update the state here
  }
}
