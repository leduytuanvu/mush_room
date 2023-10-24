abstract class VerificationState {}

class VerificationInitialState extends VerificationState {}

class VerificationLoadingState extends VerificationState {}

class VerificationErrorSubmittedState extends VerificationState {
  final String codeError;
  final String email;
  final String passwordError;
  final String rePasswordError;

  VerificationErrorSubmittedState({
    this.codeError = "",
    this.email = "",
    this.passwordError = "",
    this.rePasswordError = "",
  });
}

class VerificationReturnNullState extends VerificationState {
  final String message;

  VerificationReturnNullState({this.message = "Something wrong!"});
}

class VerificationSuccessState extends VerificationState {}
