import 'package:flutter/material.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class SetUpDevicePage extends StatelessWidget {
  SetUpDevicePage({super.key});

  final FocusScopeNode node = FocusScopeNode();
  TextEditingController verificationTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: _buildBody(theme),
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
        title: Text(
          " Device name",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildBody(ThemeData theme) {
    return Column(
      children: [
        MushRoomTextFieldWidget(
          labelText: "Name device",
          textEditingController: verificationTextEditingController,
          // errorText: ((state is VerificationErrorSubmittedState) &&
          //         (state.codeError.isNotEmpty))
          //     ? state.codeError
          //     : null,
          node: node,
          hintText: "Enter verification code",
        ),
        MushRoomTextFieldWidget(
          labelText: "Name device",
          textEditingController: verificationTextEditingController,
          // errorText: ((state is VerificationErrorSubmittedState) &&
          //         (state.codeError.isNotEmpty))
          //     ? state.codeError
          //     : null,
          node: node,
          hintText: "Enter verification code",
        ),
      ],
    );
  }
}
