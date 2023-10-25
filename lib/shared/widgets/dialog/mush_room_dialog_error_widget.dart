import 'package:flutter/material.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';

class MushRoomDialogErrorWidget extends StatefulWidget {
  const MushRoomDialogErrorWidget({Key? key, required this.error})
      : super(key: key);
  final String error;

  @override
  State<MushRoomDialogErrorWidget> createState() =>
      _MushRoomDialogErrorWidgetState();
}

class _MushRoomDialogErrorWidgetState extends State<MushRoomDialogErrorWidget> {
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
              const SizedBox(height: 10),
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                widget.error,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
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
