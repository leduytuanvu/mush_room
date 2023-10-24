import 'package:flutter/material.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/shared/widgets/dialog/mush_room_dialog_success_widget.dart';

extension CatchExceptionX on String {
  void showDialogConfirm(String message, Function() function) {
    showDialog(
      barrierDismissible: false,
      context: NavigationService().currentContext(),
      builder: (context) =>
          MushRoomDialogSuccessWidget(error: message, function: function),
    );
  }
}
