import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';

class MushRoomShowDialogConfirmWidget extends StatefulWidget {
  const MushRoomShowDialogConfirmWidget({
    Key? key,
    required this.title,
    required this.titleButton1,
    required this.titleButton2,
    required this.functionButton1,
    required this.functionButton2,
    this.isShowIcon = false,
    this.icon = const Icon(Icons.error),
    this.colorButton = AppConstants.buttonColor,
  }) : super(key: key);
  final String title;
  final Function() functionButton1;
  final Function() functionButton2;
  final String titleButton1;
  final String titleButton2;
  final bool isShowIcon;
  final Widget icon;
  final Color colorButton;

  @override
  State<MushRoomShowDialogConfirmWidget> createState() =>
      _MushRoomDialogDioExceptionWidgetState();
}

class _MushRoomDialogDioExceptionWidgetState
    extends State<MushRoomShowDialogConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: widget.functionButton1,
                  child: const Icon(Icons.close),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    widget.isShowIcon ? widget.icon : const SizedBox.shrink(),
                    const SizedBox(height: 20),
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                      width: double.infinity,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MushRoomButtonWidget(
                            label: widget.titleButton1,
                            onPressed: widget.functionButton1,
                            gradientColors: [
                              widget.colorButton,
                              widget.colorButton,
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: MushRoomButtonWidget(
                            label: widget.titleButton2,
                            onPressed: widget.functionButton2,
                            gradientColors: [
                              widget.colorButton,
                              widget.colorButton,
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              // SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
