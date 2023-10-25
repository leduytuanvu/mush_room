abstract class InforProfileState {}

class InforProfileInitialState extends InforProfileState {}

class InforProfileLoadingState extends InforProfileState {}

class InforProfileSuccessState extends InforProfileState {}

class InforProfileSubmittedUpdateUserState extends InforProfileState {
  final String usernameErrorMessage;
  final String phoneErrorMessage;

  InforProfileSubmittedUpdateUserState({
    this.usernameErrorMessage = "",
    this.phoneErrorMessage = "",
  });
}

class InforProfileSubmittedUpdatePasswordState extends InforProfileState {
  final String oldPasswordErrorMessage;
  final String newPasswordErrorMessage;
  final String confirmPasswordErrorMessage;

  InforProfileSubmittedUpdatePasswordState({
    this.oldPasswordErrorMessage = "",
    this.newPasswordErrorMessage = "",
    this.confirmPasswordErrorMessage = "",
  });
}

class InforProfileUpdateSuccessState extends InforProfileState {}

class InforProfileErrorState extends InforProfileState {}

class InforProfileReturnNullState extends InforProfileState {}

class ResetInforProfileState extends InforProfileState {}
