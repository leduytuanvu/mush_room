import 'package:flutter/material.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class ChangeInforProfilePage extends StatelessWidget {
  final String title;
  final String value;
  final bool isPassword;

  ChangeInforProfilePage({
    super.key,
    required this.title,
    required this.value,
    this.isPassword = false,
  });

  final FocusScopeNode node = FocusScopeNode();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController newPassTextEditingController = TextEditingController();
  TextEditingController confirmPassTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    textEditingController.text = value;
    final theme = Theme.of(context);
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(theme),
          body: _buildBody(theme),
        ),
        // MushRoomLoadingWidget(),
      ],
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
        title: Text(
          " Change " + title.toLowerCase(),
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildBody(ThemeData theme) => Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MushRoomTextFieldWidget(
              labelText: !isPassword ? title : "Old password",
              textEditingController: textEditingController,
              hidden: isPassword ? true : false,
              // errorText: ((state is VerificationErrorSubmittedState) &&
              //     (state.codeError.isNotEmpty))
              //     ? state.codeError
              //     : null,
              node: node,
              hintText: "Enter " + title.toUpperCase(),
            ),
            isPassword
                ? MushRoomTextFieldWidget(
                    labelText: "New password",
                    textEditingController: newPassTextEditingController,
                    hidden: true,
                    // errorText: ((state is VerificationErrorSubmittedState) &&
                    //     (state.codeError.isNotEmpty))
                    //     ? state.codeError
                    //     : null,
                    node: node,
                    hintText: "Enter " + title.toUpperCase(),
                  )
                : SizedBox.shrink(),
            isPassword
                ? MushRoomTextFieldWidget(
                    labelText: "Comfirm password",
                    textEditingController: confirmPassTextEditingController,
                    hidden: true,
                    // errorText: ((state is VerificationErrorSubmittedState) &&
                    //     (state.codeError.isNotEmpty))
                    //     ? state.codeError
                    //     : null,
                    node: node,
                    hintText: "Enter " + title.toUpperCase(),
                  )
                : SizedBox.shrink(),
            MushRoomButtonWidget(label: "Save", onPressed: () {}),
          ],
        ),
      );
}
