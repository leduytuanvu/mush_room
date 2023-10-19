import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/privacy_policy_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/terms_of_service.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                _buildTermsAndPolicy(context),
                const SizedBox(height: 34),
                _buildLoginButton(),
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
          "Sign Up",
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          "Enter your credentials to continue",
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
                  labelText: "Username",
                  textEditingController: emailTextEditingController,
                  node: _node),
              const SizedBox(
                height: 16,
              ),
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

  _buildTermsAndPolicy(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          Text(
            "By continuing you agree to our ",
            style: textTheme.bodySmall,
          ),
          GestureDetector(
            onTap: () {
              appNavigation(context, TermsOfServicePage());
            },
            child: Text(
              "Terms of Service",
              style: textTheme.bodySmall!.copyWith(
                color: AppConstants.linkColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Text(
            " and ",
            style: textTheme.bodySmall,
          ),
          GestureDetector(
            onTap: () {
              appNavigation(context, PrivacyPolicyPage());
            },
            child: Text(
              "Privacy Policy",
              style: textTheme.bodySmall!.copyWith(
                color: AppConstants.linkColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildLoginButton() => MushRoomButtonWidget(
        label: "Sign Up",
        onPressed: () {
          debugPrint("SIGN UP");
        },
      );

  _buildSignUp(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      children: [
        Text(
          "Already have an account? ",
          style: textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: () {
            appNavigation(context, LoginPage(), isComeBack: false);
          },
          child: Text(
            "Sign in",
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
