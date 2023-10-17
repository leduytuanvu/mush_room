import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:mush_room/core/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc(this.userRepository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield LoginLoading();
      try {
        final token = await userRepository.login(event.username, event.password);
        yield LoginSuccess(token);
      } catch (error) {
        yield LoginFailure(error.toString());
      }
    }
    // ... handle other events
  }
}