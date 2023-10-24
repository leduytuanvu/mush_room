import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/extensions/confirm/confirm.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_validation.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/auth/register/bloc/register_event.dart';
import 'package:mush_room/features/auth/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  RegisterBloc(this.authRepository) : super(RegisterInitialState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterSubmittedEvent) {
      try {
        yield RegisterLoadingState();
        String emailErrorMessage = AppValidation.checkEmail(event.email);
        String usernameErrorMessage = AppValidation.checkUsername(event.name);
        String phoneNumberErrorMessage =
            AppValidation.checkPhone(event.phoneNumber);
        String passwordErrorMessage =
            AppValidation.checkPassword(event.password);
        String rePasswordErrorMessage = AppValidation.checkConfirmPassword(
            event.password, event.rePassword);

        if (emailErrorMessage.isEmpty &&
            usernameErrorMessage.isEmpty &&
            passwordErrorMessage.isEmpty &&
            rePasswordErrorMessage.isEmpty &&
            phoneNumberErrorMessage.isEmpty) {
          await Future.delayed(const Duration(seconds: 1));
          final response = await authRepository.register(event);
          if (response == null) {
            yield RegisterReturnNullState();
          } else {
            const String messageRegisterSuccess =
                "Register success, please check your email to verify your registration and login again";
            messageRegisterSuccess.showDialogConfirm(
              messageRegisterSuccess,
              () {
                appNavigation(LoginPage(), isRemoveAll: true);
              },
            );
            yield RegisterInitialState();
          }
        } else {
          yield RegisterErrorSubmittedState(
            emailError: emailErrorMessage,
            nameError: usernameErrorMessage,
            phoneNumberError: phoneNumberErrorMessage,
            passwordError: passwordErrorMessage,
            rePasswordError: rePasswordErrorMessage,
          );
        }
      } on DioError catch (error) {
        error.showDialogDioException();
        yield RegisterInitialState();
      } catch (error) {
        error.toString().showDialogCatchException(error.toString());
        yield RegisterInitialState();
      }
    } else if (event is ResetRegisterEvent) {
      yield RegisterInitialState();
    }
  }
}
