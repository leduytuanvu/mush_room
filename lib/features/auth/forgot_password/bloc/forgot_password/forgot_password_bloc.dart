import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitialState());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is SendVerificationEvent) {
      yield ForgotPasswordLoadingState();
      try {
        if (event.emailErrorMessage.isEmpty) {
          yield ForgotPasswordErrorState(
            emailErrorMessage: "* Email must not empty",
          );
        } else if (!_isEmailValid(event.emailErrorMessage)) {
          yield ForgotPasswordErrorState(
            emailErrorMessage: "* Invalid email format",
          );
        } else {
          await Future.delayed(Duration(seconds: 5));
          yield ForgotPasswordSuccessState();
        }
      } catch (error) {
        yield ForgotPasswordErrorState(emailErrorMessage: error.toString());
      }
    }
  }

  // Validate email format using regex
  bool _isEmailValid(String email) {
    // Regular expression for a simple email format validation
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
    return emailRegex.hasMatch(email);
  }
}
