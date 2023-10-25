abstract class InforProfileEvent {}

class InforProfileUpdateUserEvent extends InforProfileEvent {
  final String username;
  final String phone;

  InforProfileUpdateUserEvent({required this.username, required this.phone});
}

class InforProfileUpdatePasswordEvent extends InforProfileEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  InforProfileUpdatePasswordEvent(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmPassword});
}

class ResetInforProfileEvent extends InforProfileEvent {}
