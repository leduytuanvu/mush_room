abstract class ForgotPasswordEvent {}

class SendVerificationEvent extends ForgotPasswordEvent {
  final String emailErrorMessage;

  SendVerificationEvent({
    required this.emailErrorMessage,
  });
}
