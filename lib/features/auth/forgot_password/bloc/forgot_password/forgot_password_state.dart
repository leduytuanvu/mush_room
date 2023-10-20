abstract class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String emailErrorMessage;

  ForgotPasswordErrorState({
    this.emailErrorMessage = "",
  });
}

class ForgotPasswordSuccessState extends ForgotPasswordState {}
