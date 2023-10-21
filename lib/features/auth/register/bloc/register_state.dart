import 'package:equatable/equatable.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String emailError;
  final String userNameError;
  final String passwordError;
  final String rePasswordError;

  RegisterErrorState({
    this.emailError = "",
    this.userNameError = "",
    this.passwordError = "",
    this.rePasswordError = "",
  });
}

class RegisterSuccessState extends RegisterState {}
