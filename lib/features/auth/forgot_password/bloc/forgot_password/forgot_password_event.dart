abstract class ForgotPasswordEvent {}

class SendVerificationEvent extends ForgotPasswordEvent {
  final String email;

  SendVerificationEvent({
    required this.email,
  });
}

class ResetForgotPasswordEvent extends ForgotPasswordEvent {}
