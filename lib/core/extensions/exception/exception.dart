import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/shared/widgets/dialog/mush_room_dialog_error_dio_widget.dart';

extension CatchExceptionX on String {
  void showDialogCatchException(String message) {
    showDialog(
      barrierDismissible: false,
      context: NavigationService().currentContext(),
      builder: (context) => MushRoomDialogDioExceptionWidget(error: message),
    );
  }
}

extension DioErrorX on DioError {
  void showDialogDioException() {
    switch (type) {
      case DioErrorType.connectTimeout:
        showDialog(
            barrierDismissible: false,
            context: NavigationService().currentContext(),
            builder: (context) => const MushRoomDialogDioExceptionWidget(
                error: "Network error!"));
        break;
      case DioErrorType.sendTimeout:
        showDialog(
          barrierDismissible: false,
          context: NavigationService().currentContext(),
          builder: (context) => const MushRoomDialogDioExceptionWidget(
            error: "Send timeout error!",
          ),
        );
        break;
      case DioErrorType.receiveTimeout:
        showDialog(
          barrierDismissible: false,
          context: NavigationService().currentContext(),
          builder: (context) => const MushRoomDialogDioExceptionWidget(
            error: "Receive timeout error!",
          ),
        );
        break;
      case DioErrorType.response:
        showDialog(
            barrierDismissible: false,
            context: NavigationService().currentContext(),
            builder: (context) => MushRoomDialogDioExceptionWidget(
                  error: response?.data["message"] ??
                      "Something wrong! Please try again",
                ));
        break;
      case DioErrorType.cancel:
        showDialog(
          barrierDismissible: false,
          context: NavigationService().currentContext(),
          builder: (context) => const MushRoomDialogDioExceptionWidget(
            error: "Cancel",
          ),
        );
        break;
      case DioErrorType.other:
        showDialog(
            barrierDismissible: false,
            context: NavigationService().currentContext(),
            builder: (context) => const MushRoomDialogDioExceptionWidget(
                error: "No network connection!"));
        break;
    }
  }
}
