import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/extensions/confirm/confirm.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_validation.dart';
import 'package:mush_room/features/profile/bloc/infor_profile/infor_profile_state.dart';

import 'infor_profile_event.dart';

class InforProfileBloc extends Bloc<InforProfileEvent, InforProfileState> {
  final AuthRepository authRepository;
  InforProfileBloc(this.authRepository) : super(InforProfileInitialState());

  @override
  Stream<InforProfileState> mapEventToState(InforProfileEvent event) async* {
    try {
      if (event is InforProfileUpdateUserEvent) {
        yield InforProfileLoadingState();
        String usernameErrorMessage =
            AppValidation.checkUsername(event.username);
        String phoneErrorMessage = AppValidation.checkPhone(event.phone);

        if (usernameErrorMessage.isEmpty && phoneErrorMessage.isEmpty) {
          await Future.delayed(const Duration(seconds: 1));
          final response = await authRepository.updateUser(event);
          if (response == null) {
            yield InforProfileReturnNullState();
          } else {
            const String messageRegisterSuccess = "Update success";
            final shared = injector<SharedPreferenceService>();
            shared.setUsername(event.username);
            shared.setPhone(event.phone);
            yield InforProfileUpdateSuccessState();
            messageRegisterSuccess.showDialogConfirm(
              messageRegisterSuccess,
              () {
                // appNavigation(InforProfilePage(), isComeBack: false);
                NavigationService().goBack();
                NavigationService().goBack();
              },
            );
          }
        } else {
          yield InforProfileSubmittedUpdateUserState(
            usernameErrorMessage: usernameErrorMessage,
            phoneErrorMessage: phoneErrorMessage,
          );
        }
      } else if (event is InforProfileUpdatePasswordEvent) {
        yield InforProfileLoadingState();
        String oldPasswordErrorMessage =
            AppValidation.checkPassword(event.oldPassword);
        String newPasswordErrorMessage =
            AppValidation.checkPassword(event.newPassword);
        String confirmPasswordErrorMessage = AppValidation.checkConfirmPassword(
            event.newPassword, event.confirmPassword);

        if (oldPasswordErrorMessage.isEmpty &&
            newPasswordErrorMessage.isEmpty &&
            confirmPasswordErrorMessage.isEmpty) {
          await Future.delayed(const Duration(seconds: 1));
          final response = await authRepository.updatePassword(event);
          if (response == null) {
            yield InforProfileReturnNullState();
          } else {
            const String messageRegisterSuccess = "Update success";
            yield InforProfileUpdateSuccessState();
            messageRegisterSuccess.showDialogConfirm(
              messageRegisterSuccess,
              () {
                // appNavigation(InforProfilePage(), isComeBack: false);
                NavigationService().goBack();
                NavigationService().goBack();
              },
            );
          }
        } else {
          yield InforProfileSubmittedUpdatePasswordState(
            oldPasswordErrorMessage: oldPasswordErrorMessage,
            newPasswordErrorMessage: newPasswordErrorMessage,
            confirmPasswordErrorMessage: confirmPasswordErrorMessage,
          );
        }
      } else if (event is ResetInforProfileEvent) {
        yield InforProfileInitialState();
      }
    } on DioError catch (error) {
      error.showDialogDioException();
      yield InforProfileInitialState();
    } catch (error) {
      error.toString().showDialogCatchException(error.toString());
      yield InforProfileInitialState();
    }
  }
}
