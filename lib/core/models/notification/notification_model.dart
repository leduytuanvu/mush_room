class NotificationModel {
  final int id;
  final String nameDevice;
  final String dateTime;
  final String status;

  NotificationModel({
    required this.id,
    required this.nameDevice,
    required this.dateTime,
    required this.status,
  });

  // Factory constructor to create a User instance from a map (e.g., JSON data)
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      nameDevice: json['nameDevice'],
      dateTime: json['dateTime'],
      status: json['status'],
    );
  }

  // Method to convert a User instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameDevice': nameDevice,
      'dateTime': dateTime,
      'status': status,
    };
  }
}
