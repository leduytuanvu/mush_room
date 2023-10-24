class ForgotPasswordResponse {
  final List<String> accepted;
  final List<String> rejected;
  final List<String> ehlo;
  final int envelopeTime;
  final int messageTime;
  final int messageSize;
  final String response;
  final EmailEnvelope envelope;
  final String messageId;

  ForgotPasswordResponse({
    required this.accepted,
    required this.rejected,
    required this.ehlo,
    required this.envelopeTime,
    required this.messageTime,
    required this.messageSize,
    required this.response,
    required this.envelope,
    required this.messageId,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      accepted: List<String>.from(json['accepted']),
      rejected: List<String>.from(json['rejected']),
      ehlo: List<String>.from(json['ehlo']),
      envelopeTime: json['envelopeTime'],
      messageTime: json['messageTime'],
      messageSize: json['messageSize'],
      response: json['response'],
      envelope: EmailEnvelope.fromJson(json['envelope']),
      messageId: json['messageId'],
    );
  }
}

class EmailEnvelope {
  final String from;
  final List<String> to;

  EmailEnvelope({
    required this.from,
    required this.to,
  });

  factory EmailEnvelope.fromJson(Map<String, dynamic> json) {
    return EmailEnvelope(
      from: json['from'],
      to: List<String>.from(json['to']),
    );
  }
}
