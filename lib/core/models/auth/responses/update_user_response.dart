class UpdateUserResponse {
  final int code;
  final String message;

  UpdateUserResponse({
    required this.code,
    required this.message,
  });

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }
}
