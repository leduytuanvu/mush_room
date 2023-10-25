class UserModel {
  final int id;
  final String email;
  final String name;
  final String phoneNumber;
  final String group;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.group,
  });

  // Factory constructor to create a User instance from a map (e.g., JSON data)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      group: json['group'],
    );
  }

  // Method to convert a User instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'group': group,
    };
  }
}
