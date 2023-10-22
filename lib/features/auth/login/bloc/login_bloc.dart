import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/utils/app_validation.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmittedEvent) {
      yield LoginLoadingState();
      try {
        String emailErrorMessage = AppValidation.checkEmail(event.email);
        String passwordErrorMessage = AppValidation.checkPassword(event.password);

        if (emailErrorMessage.isEmpty && passwordErrorMessage.isEmpty) {
          await Future.delayed(Duration(seconds: 5));
          final response = await authRepository.login(event);
          if(response == null) {
            yield EmailOrPasswordFailState();
          } else {
            yield LoginSuccessState();
          }
        } else {
          yield LoginErrorState(
            emailErrorMessage: emailErrorMessage,
            passwordErrorMessage: passwordErrorMessage,
          );
        }
      } catch (error) {
        yield LoginErrorState();
      }
    } else if (event is LoginEvent){
      try {
        yield LoginInitialState();
      } catch(error) {
        yield LoginErrorState();
      }
    }
  }
}