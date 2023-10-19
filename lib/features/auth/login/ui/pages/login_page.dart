import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/register_page.dart';
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

import '../../../../../shared/widgets/button/mush_room_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  _buildScaffold(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: _buildBody(context),
      );

  _buildBody(BuildContext context) => Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center horizontally
              children: [
                _buildLogo(),
                const SizedBox(height: 60),
                _buildContent(context),
                const SizedBox(height: 34),
                _buildInput(),
                const SizedBox(height: 16),
                _buildForgotPassword(context),
                const SizedBox(height: 34),
                _buildLoginButton(context),
                const SizedBox(height: 16),
                _buildSignUp(context),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      );

  _buildLogo() => Assets.icons.iconLogoApp.image(
        width: 150,
        height: 150,
      );

  _buildContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Sign In",
          style: textTheme.titleLarge,
        ),
        SizedBox(height: 6),
        Text(
          "Enter your emails and password",
          style: textTheme.titleSmall!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

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

  _buildForgotPassword(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            appNavigation(context, ForgotPasswordPage());
          },
          child: Text(
            "Forgot password",
            style: textTheme.bodySmall!.copyWith(
              color: AppConstants.linkColor,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }

  _buildLoginButton(BuildContext context) => MushRoomButtonWidget(
        label: "Sign In",
        onPressed: () {
          appNavigation(context, BottomBarPage());
        },
      );

  _buildSignUp(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: () {
            appNavigation(context, RegisterPage(), isComeBack: false);
          },
          child: Text(
            "Sign up",
            style: textTheme.bodySmall!.copyWith(
              color: AppConstants.linkColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
