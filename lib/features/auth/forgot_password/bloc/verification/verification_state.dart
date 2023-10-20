abstract class VerificationState {}

class VerificationInitialState extends VerificationState {}

class VerificationLoadingState extends VerificationState {}

class VerificationErrorState extends VerificationState {
  final String codeError;
  final String passwordError;
  final String rePasswordError;

  VerificationErrorState({
    this.codeError = "",
    this.passwordError = "",
    this.rePasswordError = "",
  });
}

class VerificationSuccessState extends VerificationState {}
