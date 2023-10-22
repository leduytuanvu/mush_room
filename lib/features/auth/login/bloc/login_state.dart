abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String emailErrorMessage;
  final String passwordErrorMessage;

  LoginErrorState({this.emailErrorMessage = "", this.passwordErrorMessage = ""});
}

class EmailOrPasswordFailState extends LoginState {
  final String message;

  EmailOrPasswordFailState({this.message = "Something wrong!"});
}