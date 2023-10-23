import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mush_room/features/auth/login/bloc/login_bloc.dart';
import 'package:mush_room/features/auth/login/bloc/login_event.dart';
import 'package:mush_room/features/auth/login/bloc/login_state.dart';
import 'package:mush_room/features/auth/register/ui/pages/register_page.dart';
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/loading/mush_room_loading_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

import '../../../../../shared/widgets/button/mush_room_button_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusScopeNode node = FocusScopeNode();
  final loginBloc = injector<LoginBloc>();
  final TextEditingController emailTextEditingController =
  TextEditingController();
  final TextEditingController passwordTextEditingController =
  TextEditingController();

  Future<bool> _onWillPop(BuildContext context) async {
    final state = loginBloc.state;
    if (state is LoginLoadingState) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: _buildScaffold(context),
    );
  }

  _buildScaffold(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _buildBody(theme),
          BlocBuilder<LoginBloc, LoginState>(
            bloc: loginBloc,
            builder: (context, state) {
              if (state is LoginLoadingState) {
                return const MushRoomLoadingWidget();
              } else if (state is LoginSuccessState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  appNavigation(context, BottomBarPage(),
                    isComeBack: false,);
                });
                loginBloc.add(ResetLoginEvent());
                return const SizedBox.shrink();
              } else if (state is LoginErrorState) {
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

  _buildBody(ThemeData theme) {
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
                  _buildContent(theme),
                  const SizedBox(height: 34),
                  _buildInput(),

                  (state is EmailOrPasswordFailState) ? Align(alignment: Alignment.centerRight,child: Text(" * Email or password incorrect", style: theme.textTheme.displaySmall,)) : SizedBox.shrink(),
                  const SizedBox(height: 10),
                  _buildForgotPassword(context, theme),
                  const SizedBox(height: 34),
                  _buildLoginButton(context),
                  const SizedBox(height: 30),
                  _buildSignUp(context, theme),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildLogo() =>
      Assets.icons.iconLogoApp.image(
        width: 150,
        height: 150,
      );

  _buildContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Sign In",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          "Enter your email and password",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

  _buildInput() {
    return Form(
      key: formKey,
      child: FocusScope(
        node: node,
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (context, state) {
            return Column(
              children: [
                MushRoomTextFieldWidget(
                  labelText: "Email",
                  textEditingController: emailTextEditingController,
                  errorText: ((state is LoginErrorState) &&
                      (state.emailErrorMessage.isNotEmpty)) ? state
                      .emailErrorMessage : null,
                  node: node,
                ),
                SizedBox(height: 6),
                MushRoomTextFieldWidget(
                  labelText: "Password",
                  textEditingController: passwordTextEditingController,
                  errorText: ((state is LoginErrorState) &&
                      (state.passwordErrorMessage.isNotEmpty)) ? state
                      .passwordErrorMessage : null,
                  hidden: true,
                  actionTextInput: ActionTextInput.end,
                  node: node,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildForgotPassword(BuildContext context, ThemeData theme) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      GestureDetector(
        onTap: () {
          appNavigation(context, ForgotPasswordPage());
        },
        child: Text(
          "Forgot password",
          style: theme.textTheme.bodySmall!.copyWith(
            color: AppConstants.linkColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ]);
  }

  _buildLoginButton(BuildContext context) {
    return MushRoomButtonWidget(
      label: "Sign In",
      onPressed: () {
        loginBloc.add(LoginSubmittedEvent(
          emailTextEditingController.text,
          passwordTextEditingController.text,
        ));
        // appNavigation(context, const BottomBarPage());
      },
    );
  }

  _buildSignUp(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: theme.textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: () {
            appNavigation(context, RegisterPage());
          },
          child: Text(
            "Sign up",
            style: theme.textTheme.bodySmall!.copyWith(
              color: AppConstants.linkColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
