abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorSubmittedState extends LoginState {
  final String emailErrorMessage;
  final String passwordErrorMessage;

  LoginErrorSubmittedState(
      {this.emailErrorMessage = "", this.passwordErrorMessage = ""});
}

class LoginReturnNullState extends LoginState {
  final String message;

  LoginReturnNullState({this.message = "Something wrong!"});
}
