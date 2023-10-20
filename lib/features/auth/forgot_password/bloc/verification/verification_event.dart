abstract class VerificationEvent {}

class ResetPasswordEvent extends VerificationEvent {
  final String verificationCode;
  final String newPassword;
  final String reNewPassword;

  ResetPasswordEvent({
    required this.verificationCode,
    required this.newPassword,
    required this.reNewPassword,
  });
}
