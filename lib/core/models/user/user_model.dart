class UserModel {
  final int id;
  final String phone;
  final String name;
  final String email;
  final String avatarUrl;
  final String role;

  UserModel({
    required this.id,
    required this.phone,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.role,
  });

  // Factory constructor to create a User instance from a map (e.g., JSON data)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      phone: json['phoneNumber'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      role: json['group'],
    );
  }

  // Method to convert a User instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phone,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'group': role,
    };
  }
}
