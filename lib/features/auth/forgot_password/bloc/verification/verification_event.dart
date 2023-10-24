abstract class VerificationEvent {}

class ChangePasswordSubmittedEvent extends VerificationEvent {
  final String verificationCode;
  final String email;
  final String newPassword;
  final String reNewPassword;

  ChangePasswordSubmittedEvent({
    required this.verificationCode,
    required this.email,
    required this.newPassword,
    required this.reNewPassword,
  });
}

class ResetVerificationEvent extends VerificationEvent {}
