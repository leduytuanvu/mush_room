import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mush_room/features/auth/login/bloc/login_bloc.dart';
import 'package:mush_room/features/auth/login/bloc/login_state.dart';
import 'package:mush_room/features/auth/register/ui/pages/register_page.dart';
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

import '../../../../../shared/widgets/button/mush_room_button_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    final loginBloc = injector<LoginBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _buildBody(context, loginBloc),
          BlocBuilder<LoginBloc, LoginState>(
            bloc: loginBloc,
            builder: (context, state) {
              if (state is LoginLoading) {
                return _buildLoading();
              } else if (state is LoginSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  appNavigation(context, const BottomBarPage(),
                      isComeBack: false);
                });
                return const SizedBox.shrink();
              } else if (state is LoginFailure) {
                return const SizedBox.shrink();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  _buildBody(BuildContext context, LoginBloc loginBloc) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FocusScopeNode node = FocusScopeNode();

    final TextEditingController emailTextEditingController =
        TextEditingController();
    final TextEditingController passwordTextEditingController =
        TextEditingController();

    return BlocBuilder<LoginBloc, LoginState>(
      bloc: loginBloc,
      builder: (context, state) {
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
                  _buildContent(context),
                  const SizedBox(height: 34),
                  _buildInput(
                    formKey,
                    node,
                    emailTextEditingController,
                    passwordTextEditingController,
                  ),
                  const SizedBox(height: 16),
                  _buildForgotPassword(context, loginBloc),
                  const SizedBox(height: 34),
                  _buildLoginButton(
                    context,
                    loginBloc,
                    emailTextEditingController,
                    passwordTextEditingController,
                  ),
                  const SizedBox(height: 16),
                  _buildSignUp(context, loginBloc),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
        const SizedBox(height: 6),
        Text(
          "Enter your email and password",
          style: textTheme.titleSmall!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

  _buildInput(
    Key formKey,
    FocusScopeNode node,
    TextEditingController emailTextEditingController,
    TextEditingController passwordTextEditingController,
  ) {
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

  _buildForgotPassword(BuildContext context, LoginBloc loginBloc) {
    final textTheme = Theme.of(context).textTheme;
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      GestureDetector(
        onTap: () {
          appNavigation(context, const ForgotPasswordPage());
        },
        child: Text(
          "Forgot password",
          style: textTheme.bodySmall!.copyWith(
            color: AppConstants.linkColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ]);
  }

  _buildLoginButton(
    BuildContext context,
    LoginBloc loginBloc,
    TextEditingController emailTextEditingController,
    TextEditingController passwordTextEditingController,
  ) {
    return MushRoomButtonWidget(
      label: "Sign In",
      onPressed: () {
        // loginBloc.add(LoginSubmitted(
        //   emailTextEditingController.text,
        //   passwordTextEditingController.text,
        // ));

        appNavigation(context, BottomBarPage());
      },
    );
  }

  _buildSignUp(BuildContext context, LoginBloc loginBloc) {
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

            appNavigation(context, const RegisterPage());

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

  _buildLoading() => Container(
        color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
}
