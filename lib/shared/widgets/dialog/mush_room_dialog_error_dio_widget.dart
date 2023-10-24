import 'package:flutter/material.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';

class MushRoomDialogDioExceptionWidget extends StatefulWidget {
  const MushRoomDialogDioExceptionWidget({Key? key, required this.error})
      : super(key: key);
  final String error;

  @override
  State<MushRoomDialogDioExceptionWidget> createState() =>
      _MushRoomDialogDioExceptionWidgetState();
}

class _MushRoomDialogDioExceptionWidgetState
    extends State<MushRoomDialogDioExceptionWidget> {
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
                Icons.error_outline,
                color: Colors.red,
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
                onPressed: () {
                  NavigationService().goBack();
                },
                gradientColors: const [
                  Colors.red,
                  Colors.red,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
