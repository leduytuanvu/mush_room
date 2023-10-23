import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitialState());

  @override
  Stream<VerificationState> mapEventToState(VerificationEvent event) async* {
    if (event is ResetPasswordEvent) {
      yield VerificationLoadingState();
      try {
        if (event.verificationCode.isEmpty &&
            event.newPassword.isEmpty &&
            event.reNewPassword.isEmpty) {
          yield VerificationErrorState(
            codeError: "* Code must not empty",
            passwordError: "* Password must not empty",
            rePasswordError: "* Re-password must not empty",
          );
        } else if (event.verificationCode.isEmpty &&
            event.newPassword.isEmpty) {
          yield VerificationErrorState(
            codeError: "* Code must not empty",
            passwordError: "* Password must not empty",
          );
        } else if (event.verificationCode.isEmpty &&
            event.reNewPassword.isEmpty) {
          yield VerificationErrorState(
            codeError: "* Code must not empty",
            rePasswordError: "* Re-password must not empty",
          );
        } else if (event.newPassword.isEmpty && event.reNewPassword.isEmpty) {
          yield VerificationErrorState(
            passwordError: "* Password must not empty",
            rePasswordError: "* Re-password must not empty",
          );
        } else if (event.verificationCode.isEmpty) {
          if (event.newPassword != event.reNewPassword) {
            yield VerificationErrorState(
              codeError: "* Code must not empty",
              rePasswordError: "* Re-password must same with password",
            );
          } else {
            yield VerificationErrorState(
              codeError: "* Code must not empty",
            );
          }
        } else if (event.newPassword.isEmpty) {
          yield VerificationErrorState(
            passwordError: "* Password must not empty",
          );
        } else if (event.reNewPassword.isEmpty) {
          yield VerificationErrorState(
            rePasswordError: "* Re-password must not empty",
          );
        } else if (event.newPassword != event.reNewPassword) {
          yield VerificationErrorState(
            rePasswordError: "* Re-password must same with password",
          );
        } else {
          await Future.delayed(Duration(seconds: 5));
          yield VerificationSuccessState();
        }
      } catch (error) {
        yield VerificationErrorState();
      }
    } else if (event is ResetVerificationEvent) {
      yield VerificationInitialState();
    }
  }
}
