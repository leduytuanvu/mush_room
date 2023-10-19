import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/shared/widgets/text_field/validation.dart';

enum ActionTextInput { next, end }

enum Validation { check, unknown }

enum ModeInput { text, number }

enum TypeInput {
  fullName,
  username,
  phoneNumber,
  email,
  password,
  confirmPassword,
  address
}

class MushRoomTextFieldWidget extends StatefulWidget {
  final bool autofocus;
  final TextEditingController textEditingController;
  final String? labelText;
  final String? hintText;
  final ActionTextInput actionTextInput;
  final bool hidden;
  final Decoration? decoration;
  final String errorText;

  final ModeInput modeInput;

  const MushRoomTextFieldWidget({
    Key? key,
    this.autofocus = false,
    this.labelText,
    this.hintText,
    this.decoration,
    this.hidden = false,
    this.errorText = "",
    this.modeInput = ModeInput.text,

    required this.textEditingController,
    this.actionTextInput = ActionTextInput.next,
  }) : super(key: key);

  @override
  State<MushRoomTextFieldWidget> createState() =>
      _MushRoomTextFieldWidgetState();
}

class _MushRoomTextFieldWidgetState extends State<MushRoomTextFieldWidget> {
  bool myHidden = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: widget.decoration ?? const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            autofocus: widget.autofocus,
            controller: widget.textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              suffixIcon: (widget.hidden)
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.textEditingController.text != "") {
                            myHidden = !myHidden;
                          }
                        });
                      },
                      icon: Icon(
                          myHidden ? Icons.visibility : Icons.visibility_off))
                  : const SizedBox(),
              labelText: widget.labelText,
              labelStyle: AppTextStyle.bodyTextStyleH2(),
              hintText: widget.hintText,
              hintStyle: textTheme.labelMedium,
              filled: true,
            ),
            keyboardType: (widget.modeInput == ModeInput.text)
                ? TextInputType.text
                : TextInputType.number,
            // Show a numeric keyboard
            inputFormatters: (widget.modeInput == ModeInput.number)
                ? [
                    FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  ]
                : null,
            style: AppTextStyle.bodyTextStyleH3(),
            obscureText: (widget.hidden) ? myHidden : false,
            textInputAction: textInputAction(),
            onFieldSubmitted: (_) {
              if (widget.hidden && textInputAction() == TextInputAction.next) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
          (widget.errorText.isNotEmpty)
              ? SizedBox(
                  height: 32,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        widget.errorText,
                        style: AppTextStyle.errorTextSmail(),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 32,
                )
        ],
      ),
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

// void Function()? onEditingComplete(ActionTextInput actionTextInput) {
//   switch (actionTextInput) {
//     case ActionTextInput.next:
//       return widget.node.nextFocus;
//     case ActionTextInput.end:
//       return widget.node.unfocus;
//   }
// }
}
