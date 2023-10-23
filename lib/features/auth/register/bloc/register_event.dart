abstract class RegisterEvent {}

class RegisterNewEvent extends RegisterEvent {
  final String email;
  final String username;
  final String password;
  final String rePassword;

  RegisterNewEvent({
    required this.email,
    required this.username,
    required this.password,
    required this.rePassword,
  });
}

class ResetRegisterEvent extends RegisterEvent {}