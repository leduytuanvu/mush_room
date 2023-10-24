import 'package:flutter/material.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class ReportAttemptPage extends StatelessWidget {
  ReportAttemptPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusScopeNode node = FocusScopeNode();
  final TextEditingController userNameText = TextEditingController();
  final TextEditingController emailText = TextEditingController();
  final TextEditingController problemText = TextEditingController();

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
          " Report Attempt",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildBody(ThemeData theme) {
    userNameText.text = "leduytuanvu";
    emailText.text = "leduytuanvu.work@gmail.com";
    problemText.text = "leduytuanvu.work@gmail.com";
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            MushRoomTextFieldWidget(
              labelText: "Username",
              textEditingController: emailText,
              // errorText: ((state is LoginErrorSubmittedState) &&
              //     (state.emailErrorMessage.isNotEmpty))
              //     ? state.emailErrorMessage
              //     : null,
              node: node,
            ),
            SizedBox(height: 10),
            MushRoomTextFieldWidget(
              labelText: "Email",
              textEditingController: emailText,
              // errorText: ((state is LoginErrorSubmittedState) &&
              //     (state.emailErrorMessage.isNotEmpty))
              //     ? state.emailErrorMessage
              //     : null,
              node: node,
            ),
            SizedBox(height: 10),
            MushRoomTextFieldWidget(
              labelText: "Problem",
              textEditingController: emailText,
              numberLines: 10,
              // errorText: ((state is LoginErrorSubmittedState) &&
              //     (state.emailErrorMessage.isNotEmpty))
              //     ? state.emailErrorMessage
              //     : null,
              node: node,
            ),
            MushRoomButtonWidget(label: "Send Report", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
