import 'package:mush_room/core/utils/app_logger.dart';

class RegisterResponse {
  final int id;
  final String email;
  final String phoneNumber;

  RegisterResponse({
    required this.id,
    required this.email,
    required this.phoneNumber,
  });

  // Factory constructor to create a User instance from a map (e.g., JSON data)
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    AppLogger.i(json.toString());
    return RegisterResponse(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  // Method to convert a User instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
