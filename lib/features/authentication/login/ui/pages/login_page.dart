import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

import '../../../../../shared/widgets/button/mush_room_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final FocusScopeNode _node = FocusScopeNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() => Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildBody(),
      );

  _buildBody() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(flex: 3, child: _buildLogo()),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  _buildContent(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildInput(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildForgotPassword(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildLoginButton(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildSignUp(),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            )
          ],
        ),
      );

  _buildLogo() => Assets.icons.iconLogoApp.image(
        width: 150,
        height: 150,
      );

  _buildContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Login",
            style: AppTextStyle.bodyTextStyleH1(),
          ),
          Text("Enter your emails and password",
              style: AppTextStyle.bodyTextStyleH3()),
        ],
      );

  _buildInput() => Form(
        key: _formKey,
        child: FocusScope(
          node: _node,
          child: Column(
            children: [
              MushRoomTextFieldWidget(
                  labelText: "Email",
                  textEditingController: emailTextEditingController,
                  node: _node),
              const SizedBox(
                height: 16,
              ),
              MushRoomTextFieldWidget(
                  labelText: "Password",
                  textEditingController: passwordTextEditingController,
                  hidden: true,
                  actionTextInput: ActionTextInput.end,
                  node: _node),
            ],
          ),
        ),
      );

  _buildForgotPassword() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Forgot Password?",
              style: AppTextStyle.bodyTextStyleH3(),
            ),
          )
        ],
      );

  _buildLoginButton() => MushRoomButtonWidget(
        label: "Log In",
        onPressed: () {
          debugPrint("Log In");
        },
      );

  _buildSignUp() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don’t have an account? ",
            style: AppTextStyle.bodyTextStyleH3(),
          ),
          InkWell(
            onTap: () {
              debugPrint("Singup");
            },
            child: Text(
              "SingUp",
              style: AppTextStyle.bodyTextStyleH3(color: Color(0xff53B175)),
            ),
          ),
        ],
      );
}
