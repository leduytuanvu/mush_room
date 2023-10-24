import 'package:flutter/material.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';

class MushRoomDialogSuccessWidget extends StatefulWidget {
  const MushRoomDialogSuccessWidget({
    Key? key,
    required this.error,
    required this.function,
  }) : super(key: key);
  final String error;
  final Function() function;

  @override
  State<MushRoomDialogSuccessWidget> createState() =>
      _MushRoomDialogDioExceptionWidgetState();
}

class _MushRoomDialogDioExceptionWidgetState
    extends State<MushRoomDialogSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                widget.error,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
              ),
              MushRoomButtonWidget(
                label: "OK",
                onPressed: widget.function,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
