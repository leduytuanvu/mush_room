class AuthModel {
  final int id;
  final String name;
  final String email;
  final String avatarUrl;
  final String accessToken;
  final String refreshToken;

  AuthModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.accessToken,
    required this.refreshToken,
  });

  // Factory constructor to create a User instance from a map (e.g., JSON data)
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  // Method to convert a User instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
