class UpdatePasswordResponse {
  final List<int> data;

  UpdatePasswordResponse({required this.data});

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'];
    final List<int> data = dataList.cast<int>();

    return UpdatePasswordResponse(data: data);
  }
}
