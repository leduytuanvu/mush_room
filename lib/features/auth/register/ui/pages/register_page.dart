import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/auth/register/bloc/register_bloc.dart'; // Import the RegisterBloc
import 'package:mush_room/features/auth/register/ui/pages/privacy_policy_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/terms_of_service.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

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
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              _buildLogo(),
              const SizedBox(height: 60),
              _buildTitle(context),
              const SizedBox(height: 34),
              _buildFormInput(),
              const SizedBox(height: 16),
              _buildTermsAndPolicy(context),
              const SizedBox(height: 34),
              _buildButtonSignUp(),
              const SizedBox(height: 16),
              _buildAlreadyHaveAccount(context),
              const SizedBox(height: 60),
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

  _buildFormInput() {
    return Form(
      key: _formKey,
      child: FocusScope(
        node: _node,
        child: Column(
          children: [
            // MushRoomTextFieldWidget(
            //   labelText: "Full name",
            //   textEditingController: fullNameTextEditingController,
            //   node: _node,
            // ),
            // MushRoomTextFieldWidget(
            //   labelText: "Phone",
            //   textEditingController: phoneTextEditingController,
            //   node: _node,
            //   modeInput: ModeInput.number,
            // ),
            // MushRoomTextFieldWidget(
            //   labelText: "Address",
            //   textEditingController: addressTextEditingController,
            //   node: _node,
            // ),
            MushRoomTextFieldWidget(
              labelText: "Email",
              textEditingController: emailTextEditingController,
              node: _node,
            ),
            MushRoomTextFieldWidget(
              labelText: "Username",
              textEditingController: userNameTextEditingController,
              node: _node,
            ),
            MushRoomTextFieldWidget(
              labelText: "Password",
              textEditingController: passwordTextEditingController,
              hidden: true,
              node: _node,
            ),
            MushRoomTextFieldWidget(
              labelText: "Confirm password",
              textEditingController: confirmPasswordTextEditingController,
              hidden: true,
              actionTextInput: ActionTextInput.end,
              node: _node,
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
