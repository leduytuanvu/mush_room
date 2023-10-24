abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorSubmittedState extends RegisterState {
  final String emailError;
  final String nameError;
  final String phoneNumberError;
  final String passwordError;
  final String rePasswordError;

  RegisterErrorSubmittedState({
    this.emailError = "",
    this.nameError = "",
    this.phoneNumberError = "",
    this.passwordError = "",
    this.rePasswordError = "",
  });
}

class RegisterReturnNullState extends RegisterState {
  final String message;

  RegisterReturnNullState({this.message = "Something wrong!"});
}

class RegisterSuccessState extends RegisterState {}
