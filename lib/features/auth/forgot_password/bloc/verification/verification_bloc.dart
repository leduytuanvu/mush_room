import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/extensions/confirm/confirm.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_validation.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_state.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final AuthRepository authRepository;
  VerificationBloc(this.authRepository) : super(VerificationInitialState());

  @override
  Stream<VerificationState> mapEventToState(VerificationEvent event) async* {
    if (event is ChangePasswordSubmittedEvent) {
      try {
        yield VerificationLoadingState();
        String codeErrorMessage =
            AppValidation.checkCode(event.verificationCode);
        String passwordErrorMessage =
            AppValidation.checkCode(event.newPassword);
        String rePasswordErrorMessage =
            AppValidation.checkCode(event.reNewPassword);
        if (codeErrorMessage.isEmpty &&
            passwordErrorMessage.isEmpty &&
            rePasswordErrorMessage.isEmpty) {
          await Future.delayed(const Duration(seconds: 1));
          final response = await authRepository.changePassword(event);
          if (response == null) {
            yield VerificationReturnNullState();
          } else {
            const String message =
                "Change password success. Please login again";
            message.showDialogConfirm(
              message,
              () {
                appNavigation(LoginPage(), isRemoveAll: true);
              },
            );
            yield VerificationInitialState();
          }
        } else {
          yield VerificationErrorSubmittedState(
            codeError: codeErrorMessage,
            passwordError: passwordErrorMessage,
            rePasswordError: rePasswordErrorMessage,
          );
        }
      } on DioError catch (error) {
        error.showDialogDioException();
        yield VerificationInitialState();
      } catch (error) {
        error.toString().showDialogCatchException(error.toString());
        yield VerificationInitialState();
      }
    } else if (event is ResetVerificationEvent) {
      yield VerificationInitialState();
    }
  }
}
