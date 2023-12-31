import 'package:mush_room/core/utils/app_logger.dart';

class LoginResponse {
  final String accessToken;
  final int expiresIn;
  final String tokenType;
  final String refreshToken;
  final String idToken;

  LoginResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    required this.refreshToken,
    required this.idToken,
  });

  // Factory constructor to create a User instance from a map (e.g., JSON data)
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    AppLogger.i(json.toString());
    return LoginResponse(
      accessToken: json['AccessToken'] ?? '',
      expiresIn: json['ExpiresIn'] ?? 0,
      tokenType: json['TokenType'] ?? '',
      refreshToken: json['RefreshToken'] ?? '',
      idToken: json['IdToken'] ?? '',
    );
  }

  // Method to convert a User instance to a map
  Map<String, dynamic> toJson() {
    return {
      'AccessToken': accessToken,
      'ExpiresIn': expiresIn,
      'TokenType': tokenType,
      'RefreshToken': refreshToken,
      'IdToken': idToken,
    };
  }
}
