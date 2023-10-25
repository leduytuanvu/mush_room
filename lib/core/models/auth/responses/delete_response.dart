class DeleteResponse {
  final int code;
  final String message;

  DeleteResponse({
    required this.code,
    required this.message,
  });

  factory DeleteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResponse(
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}
