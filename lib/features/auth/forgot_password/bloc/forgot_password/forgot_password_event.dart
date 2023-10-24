abstract class ForgotPasswordEvent {}

class ForgotPasswordSubmittedEvent extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordSubmittedEvent({
    required this.email,
  });
}

class ResetForgotPasswordEvent extends ForgotPasswordEvent {}
