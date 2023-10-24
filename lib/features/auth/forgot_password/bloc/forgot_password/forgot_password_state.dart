abstract class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String emailErrorMessage;

  ForgotPasswordErrorState({
    this.emailErrorMessage = "",
  });
}

class ForgotPasswordErrorSubmittedState extends ForgotPasswordState {
  final String emailErrorMessage;

  ForgotPasswordErrorSubmittedState({this.emailErrorMessage = ""});
}

class ForgotPasswordReturnNullState extends ForgotPasswordState {
  final String message;

  ForgotPasswordReturnNullState({this.message = "Something wrong!"});
}

class ForgotPasswordSuccessState extends ForgotPasswordState {}
