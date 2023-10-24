import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_validation.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_state.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/verification_page.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepository;
  ForgotPasswordBloc(this.authRepository) : super(ForgotPasswordInitialState());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordSubmittedEvent) {
      try {
        yield ForgotPasswordLoadingState();
        String emailErrorMessage = AppValidation.checkEmail(event.email);

        if (emailErrorMessage.isEmpty) {
          await Future.delayed(const Duration(seconds: 1));
          final response = await authRepository.forgotPassword(event);
          if (response == null) {
            yield ForgotPasswordReturnNullState();
          } else {
            appNavigation(VerificationPage(
              email: event.email,
            ));
            yield ForgotPasswordInitialState();
          }
        } else {
          yield ForgotPasswordErrorSubmittedState(
            emailErrorMessage: emailErrorMessage,
          );
        }
      } on DioError catch (error) {
        error.showDialogDioException();
        yield ForgotPasswordInitialState();
      } catch (error) {
        error.toString().showDialogCatchException(error.toString());
        yield ForgotPasswordInitialState();
      }
    } else if (event is ResetForgotPasswordEvent) {
      yield ForgotPasswordInitialState();
    }
  }
}
