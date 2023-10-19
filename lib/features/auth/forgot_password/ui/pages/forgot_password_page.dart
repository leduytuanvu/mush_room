import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mush_room/features/auth/register/bloc/register_bloc.dart'; // Import the RegisterBloc
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Use injector to get the RegisterBloc
    final registerBloc = GetIt.instance<RegisterBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change the color of the back icon
        ),
      ),
      body: _buildBody(context, registerBloc),
    );
  }

  Widget _buildBody(BuildContext context, RegisterBloc registerBloc) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FocusScopeNode node = FocusScopeNode();

    TextEditingController emailTextEditingController = TextEditingController();
    TextEditingController passwordTextEditingController =
        TextEditingController();

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 6),
            _buildTitle(context),
            const SizedBox(height: 34),
            _buildFormInput(formKey, node, emailTextEditingController,
                passwordTextEditingController),
            const SizedBox(height: 20),
            _buildButtonSignUp(),
            const SizedBox(height: 160),
          ],
        ),
      ),
    );
  }

  _buildTitle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Forgot Password",
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          "Enter email to get your password",
          style: textTheme.titleSmall!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

  _buildFormInput(
      Key formKey,
      FocusScopeNode node,
      TextEditingController emailTextEditingController,
      TextEditingController passwordTextEditingController) {
    return Form(
      key: formKey,
      child: FocusScope(
        node: node,
        child: Column(
          children: [
            MushRoomTextFieldWidget(
              labelText: "Email",
              textEditingController: emailTextEditingController,
              node: node,
            ),
          ],
        ),
      ),
    );
  }

  _buildButtonSignUp() => MushRoomButtonWidget(
        label: "Send Password",
        onPressed: () {
          debugPrint("SIGN UP");
        },
      );
}
