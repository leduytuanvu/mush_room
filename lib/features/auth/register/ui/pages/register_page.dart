import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';

import 'package:mush_room/core/utils/app_text_style.dart';

import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/auth/register/bloc/register_bloc.dart'; // Import the RegisterBloc
import 'package:mush_room/features/auth/register/ui/pages/privacy_policy_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/terms_of_service.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/text_field/validation.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameTextEditingController =
  TextEditingController();
  final TextEditingController phoneTextEditingController =
  TextEditingController();
  final TextEditingController addressTextEditingController =
  TextEditingController();
  final TextEditingController usernameTextEditingController =
      TextEditingController();

  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  final FocusScopeNode _node = FocusScopeNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Validation validation = Validation.unknown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Assets.icons.iconLogoApp.image(
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Sign Up",
                  style: AppTextStyle.titleTextStyleH1(),
                ),
                const SizedBox(height: 6),
                Text(
                  "Enter your credentials to continue",
                  style: AppTextStyle.titleTextStyleH3(),
                ),
                const SizedBox(height: 16),
                MushRoomTextFieldWidget(
                  textEditingController: fullNameTextEditingController,
                  labelText: "Full name",
                ),
                MushRoomTextFieldWidget(
                  textEditingController: phoneTextEditingController,
                  labelText: "Phone",
                  modeInput: ModeInput.number,
                  errorText: (validation == Validation.unknown)
                      ? ""
                      : MushRoomValidation.phoneNumber(
                      phoneTextEditingController.text),
                ),
                MushRoomTextFieldWidget(
                  textEditingController: addressTextEditingController,
                  labelText: "Address",
                ),
                MushRoomTextFieldWidget(
                  textEditingController: usernameTextEditingController,
                  labelText: "Username",
                ),
                MushRoomTextFieldWidget(
                  textEditingController: emailTextEditingController,
                  labelText: "Email",
                  errorText: (validation == Validation.unknown)
                      ? ""
                      : MushRoomValidation.email(
                          emailTextEditingController.text),
                ),
                MushRoomTextFieldWidget(
                  textEditingController: passwordTextEditingController,
                  labelText: "Password",
                  hidden: true,
                  errorText: (validation == Validation.unknown)
                      ? ""
                      : MushRoomValidation.password(
                          passwordTextEditingController.text),
                ),
                MushRoomTextFieldWidget(
                  textEditingController: confirmPasswordTextEditingController,
                  labelText: "Confirm password",
                  hidden: true,
                  errorText: (validation == Validation.unknown)
                      ? ""
                      : MushRoomValidation.confirmPassword(
                          passwordTextEditingController.text,
                          confirmPasswordTextEditingController.text,
                        ),
                  actionTextInput: ActionTextInput.end,
                ),
                Wrap(
                  children: [
                    Text(
                      "By continuing you agree to our ",
                      style: AppTextStyle.titleTextStyleH3(),
                    ),
                    GestureDetector(
                      onTap: () {
                        appNavigation(context, const TermsOfServicePage());
                      },
                      child: Text(
                        "Terms of Service",
                        style: AppTextStyle.titleTextStyleH3(
                            color: AppConstants.linkColor),
                      ),
                    ),
                    Text(
                      " and ",
                      style: AppTextStyle.titleTextStyleH3(),
                    ),
                    const SizedBox(height: 22),
                    GestureDetector(
                      onTap: () {
                        appNavigation(context, const PrivacyPolicyPage());
                      },
                      child: Text(
                        "Privacy Policy",
                        style: AppTextStyle.titleTextStyleH3(
                            color: AppConstants.linkColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MushRoomButtonWidget(
                    label: "Sign Up",
                    onPressed: () {
                      setState(() {
                        validation = Validation.check;
                      });
                    }),
                const SizedBox(height: 20),
                Center(
                  child: Wrap(
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppTextStyle.titleTextStyleH3(),
                      ),
                      Text(
                        "Sign In",
                        style: AppTextStyle.labelTextStyleH3(
                            color: AppConstants.linkColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    // Use injector to get the RegisterBloc
    final registerBloc = GetIt.instance<RegisterBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _buildBody(context, registerBloc),
    );
  }

  Widget _buildBody(BuildContext context, RegisterBloc registerBloc) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FocusScopeNode node = FocusScopeNode();

    TextEditingController emailTextEditingController = TextEditingController();
    TextEditingController passwordTextEditingController =
        TextEditingController();

    return Center(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 60),
              _buildTitle(context),
              const SizedBox(height: 34),
              _buildFormInput(formKey, node, emailTextEditingController,
                  passwordTextEditingController),
              const SizedBox(height: 16),
              _buildTermsAndPolicy(context),
              const SizedBox(height: 34),
              _buildButtonSignUp(),
              const SizedBox(height: 16),
              _buildAlreadyHaveAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildLogo() => Assets.icons.iconLogoApp.image(
        width: 150,
        height: 150,
      );

  _buildTitle(BuildContext context) {
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
              labelText: "Username",
              textEditingController: emailTextEditingController,
              node: node,
            ),
            const SizedBox(height: 16),
            MushRoomTextFieldWidget(
              labelText: "Email",
              textEditingController: emailTextEditingController,
              node: node,
            ),
            const SizedBox(height: 16),
            MushRoomTextFieldWidget(
              labelText: "Password",
              textEditingController: passwordTextEditingController,
              hidden: true,
              actionTextInput: ActionTextInput.end,
              node: node,
            ),
          ],
        ),
      ),
    );
  }

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

  _buildButtonSignUp() => MushRoomButtonWidget(
        label: "Sign Up",
        onPressed: () {

          debugPrint("SIGN UP");
        },
      );

  _buildAlreadyHaveAccount(BuildContext context) {
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
