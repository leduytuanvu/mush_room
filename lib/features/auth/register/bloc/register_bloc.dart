import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/core/utils/app_validation.dart';
import 'package:mush_room/features/auth/register/bloc/register_event.dart';
import 'package:mush_room/features/auth/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitialState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterNewEvent) {
      yield RegisterLoadingState();
      try {
        String emailErrorMessage = AppValidation.checkEmail(event.email);
        String usernameErrorMessage = AppValidation.checkUsername(event.username);
        String passwordErrorMessage = AppValidation.checkPassword(event.password);
        String rePasswordErrorMessage = AppValidation.checkConfirmPassword(event.password, event.rePassword);

        if (emailErrorMessage.isEmpty && usernameErrorMessage.isEmpty && passwordErrorMessage.isEmpty && rePasswordErrorMessage.isEmpty) {
          await Future.delayed(Duration(seconds: 5));
          yield RegisterSuccessState();
        } else {
          yield RegisterErrorState(
            emailError: emailErrorMessage,
            userNameError: usernameErrorMessage,
            passwordError: passwordErrorMessage,
            rePasswordError: rePasswordErrorMessage,
          );
        }
      } catch (error) {
        yield RegisterErrorState();
      }
    } else if (event is ResetRegisterEvent) {
      yield RegisterInitialState();
    }
  }
}