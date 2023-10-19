import 'package:flutter/material.dart';

enum ActionTextInput { next, end, password }

class MushRoomTextFieldWidget extends StatefulWidget {
  final bool autofocus;
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final ActionTextInput actionTextInput;
  final FocusScopeNode node;
  final bool hidden;
  final Decoration? decoration;

  const MushRoomTextFieldWidget(
      {Key? key,
      this.autofocus = false,
      this.labelText = "",
      this.hintText = "Enter text",
      this.decoration,
      this.hidden = false,
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
    return Container(
      decoration: widget.decoration ?? const BoxDecoration(color: Colors.white),
      child: TextFormField(
        autofocus: widget.autofocus,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 0.2, color: Colors.black12),
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
                  icon:
                      Icon(myHidden ? Icons.visibility_off : Icons.visibility))
              : const SizedBox(),
          labelText: widget.labelText,
          labelStyle: textTheme.bodySmall,
          hintText: widget.hintText,
          hintStyle: textTheme.bodySmall,
          filled: true,
          errorStyle: textTheme.bodySmall,
        ),
        style: textTheme.bodySmall,
        obscureText: myHidden,
        textInputAction: textInputAction(),
        onEditingComplete: onEditingComplete(widget.actionTextInput),
      ),
    );
  }

  TextInputAction textInputAction() {
    switch (widget.actionTextInput) {
      case ActionTextInput.next:
        return TextInputAction.next;
      case ActionTextInput.end:
        return TextInputAction.done;
      case ActionTextInput.password:
        return TextInputAction.next;
    }
  }

  void Function()? onEditingComplete(ActionTextInput actionTextInput) {
    switch (actionTextInput) {
      case ActionTextInput.next:
        return widget.node.nextFocus;
      case ActionTextInput.end:
        return widget.node.unfocus;
      case ActionTextInput.password:
        return widget.node.nextFocus;
    }
  }
}
