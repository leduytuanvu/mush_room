import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_validation.dart';
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmittedEvent) {
      try {
        yield LoginLoadingState();
        String emailErrorMessage = AppValidation.checkEmail(event.email);
        String passwordErrorMessage =
            AppValidation.checkPassword(event.password);

        if (emailErrorMessage.isEmpty && passwordErrorMessage.isEmpty) {
          await Future.delayed(const Duration(seconds: 1));
          final response = await authRepository.login(event);
          if (response == null) {
            yield LoginReturnNullState();
          } else {
            appNavigation(BottomBarPage(), isRemoveAll: true);
            yield LoginInitialState();
          }
        } else {
          yield LoginErrorSubmittedState(
            emailErrorMessage: emailErrorMessage,
            passwordErrorMessage: passwordErrorMessage,
          );
        }
      } on DioError catch (error) {
        error.showDialogDioException();
        yield LoginInitialState();
      } catch (error) {
        error.toString().showDialogCatchException(error.toString());
        yield LoginInitialState();
      }
    }
  }
}
