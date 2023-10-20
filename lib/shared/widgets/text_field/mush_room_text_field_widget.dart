import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mush_room/core/utils/app_text_style.dart';

enum ActionTextInput { next, end }

enum ModeInput { text, number }

class MushRoomTextFieldWidget extends StatefulWidget {
  final bool autofocus;
  final TextEditingController textEditingController;
  final String? labelText;
  final String? hintText;
  final ActionTextInput actionTextInput;
  final FocusScopeNode node;
  final String? errorText;
  final bool hidden;
  final Decoration? decoration;
  final ModeInput modeInput;

  const MushRoomTextFieldWidget(
      {Key? key,
      this.autofocus = false,
      this.labelText,
      this.hintText,
      this.decoration,
      this.hidden = false,
      this.errorText,
      this.modeInput = ModeInput.text,
      required this.textEditingController,
      this.actionTextInput = ActionTextInput.next,
      required this.node})
      : super(key: key);

  @override
  State<MushRoomTextFieldWidget> createState() =>
      _MushRoomTextFieldWidgetState();
}

class _MushRoomTextFieldWidgetState extends State<MushRoomTextFieldWidget> {
  bool myHidden = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    myHidden = widget.hidden;
    return Column(
      children: [
        TextFormField(
          autofocus: widget.autofocus,
          controller: widget.textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0.2,
                color: Colors.black12,
              ),
            ),
            suffixIcon: (widget.hidden)
                ? IconButton(
                    onPressed: () {
                      setState(
                        () {
                          if (widget.textEditingController.text != "") {
                            myHidden = !myHidden;
                          }
                        },
                      );
                    },
                    icon: Icon(
                      myHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : const SizedBox(),
            labelText: widget.labelText,
            labelStyle: textTheme.bodySmall,
            hintText: widget.hintText,
            hintStyle: AppTextStyle.bodyTextStyleH3(color: Colors.grey),
            filled: true,
            errorStyle: textTheme.bodySmall,
          ),
          keyboardType: keyboardType(), // Show a numeric keyboard
          inputFormatters: (widget.modeInput == ModeInput.number)
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                ]
              : null,
          style: textTheme.bodySmall,
          obscureText: myHidden,
          textInputAction: textInputAction(),
          onFieldSubmitted: (_) {
            if (widget.hidden &&
                widget.actionTextInput == ActionTextInput.next) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
        (widget.errorText != null)
            ? SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.errorText!,
                      style: textTheme.displaySmall,
                    ),
                  ],
                ),
              )
            : const SizedBox(height: 20)
      ],
    );
  }

  TextInputAction textInputAction() {
    switch (widget.actionTextInput) {
      case ActionTextInput.next:
        return TextInputAction.next;
      case ActionTextInput.end:
        return TextInputAction.done;
    }
  }

  TextInputType keyboardType() {
    switch (widget.modeInput) {
      case ModeInput.text:
        return TextInputType.text;
      case ModeInput.number:
        return TextInputType.number;
    }
  }

  void Function()? onEditingComplete(ActionTextInput actionTextInput) {
    switch (actionTextInput) {
      case ActionTextInput.next:
        return widget.node.nextFocus;
      case ActionTextInput.end:
        return widget.node.unfocus;
    }
  }
}
