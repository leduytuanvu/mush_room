import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/models/auth/requests/login_request.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:mush_room/core/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield LoginLoading();
      try {
        final response = await authRepository.login(event);
        yield LoginSuccess(response.accessToken);
      } catch (error) {
        yield LoginFailure(error.toString());
      }
    }
  }
}