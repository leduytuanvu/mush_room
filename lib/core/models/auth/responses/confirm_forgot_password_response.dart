class ConfirmForgotPasswordResponse {
  final List<int> data;

  ConfirmForgotPasswordResponse({required this.data});

  factory ConfirmForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'];
    final List<int> data = dataList.cast<int>();

    return ConfirmForgotPasswordResponse(data: data);
  }
}
