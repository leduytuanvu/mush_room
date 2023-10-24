abstract class RegisterEvent {}

class RegisterSubmittedEvent extends RegisterEvent {
  final String email;
  final String name;
  final String phoneNumber;
  final String password;
  final String rePassword;

  RegisterSubmittedEvent({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.rePassword,
  });
}

class ResetRegisterEvent extends RegisterEvent {}
