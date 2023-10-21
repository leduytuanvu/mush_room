import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/register/bloc/register_bloc.dart'; // Import the RegisterBloc
import 'package:mush_room/features/auth/register/bloc/register_event.dart';
import 'package:mush_room/features/auth/register/bloc/register_state.dart';
import 'package:mush_room/features/auth/register/ui/pages/privacy_policy_page.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/loading/mush_room_loading_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();
  final registerBloc = GetIt.instance<RegisterBloc>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();

  Future<bool> _onWillPop(BuildContext context) async {
    final state = registerBloc.state;
    if (state is RegisterLoadingState) {
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
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: _buildAppBar(),
          body: _buildBody(context, theme),
        ),
        BlocBuilder<RegisterBloc, RegisterState>(
          bloc: registerBloc,
          builder: (context, state) {
            if (state is RegisterLoadingState) {
              FocusScope.of(context).unfocus();
              return const MushRoomLoadingWidget();
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  _buildAppBar() => AppBar(
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  _buildBody(BuildContext context, ThemeData theme) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            _buildTitle(context, theme),
            const SizedBox(height: 34),
            _buildFormInput(),
            const SizedBox(height: 16),
            _buildTermsAndPolicy(context, theme),
            const SizedBox(height: 32),
            _buildButtonSignUp(),
          ],
        ),
      ),
    );
  }

  _buildTitle(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Sign Up",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          "Enter your credentials to continue",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

  _buildFormInput() {
    return Form(
      key: _formKey,
      child: FocusScope(
        node: _node,
        child: BlocBuilder<RegisterBloc, RegisterState>(
          bloc: registerBloc,
          builder: (context, state) {
            return Column(
                  children: [
                    MushRoomTextFieldWidget(
                      labelText: "Email",
                      textEditingController: emailTextEditingController,
                      errorText: ((state is RegisterErrorState) &&
                          (state.emailError.isNotEmpty)) ? state
                          .emailError : null,
                      node: _node,
                    ),
                    SizedBox(height: 6),
                    MushRoomTextFieldWidget(
                      labelText: "Username",
                      textEditingController: userNameTextEditingController,
                      errorText: ((state is RegisterErrorState) &&
                          (state.userNameError.isNotEmpty)) ? state
                          .userNameError : null,
                      node: _node,
                    ),
                    SizedBox(height: 6),
                    MushRoomTextFieldWidget(
                      labelText: "Password",
                      textEditingController: passwordTextEditingController,
                      errorText: ((state is RegisterErrorState) &&
                          (state.passwordError.isNotEmpty)) ? state
                          .passwordError : null,
                      hidden: true,
                      node: _node,
                    ),
                    const SizedBox(height: 6),
                    MushRoomTextFieldWidget(
                      labelText: "Confirm password",
                      textEditingController: confirmPasswordTextEditingController,
                      errorText: ((state is RegisterErrorState) &&
                          (state.rePasswordError.isNotEmpty)) ? state
                          .rePasswordError : null,
                      hidden: true,
                      actionTextInput: ActionTextInput.end,
                      node: _node,
                    ),
                  ],
                );
          },
),
      ),
    );
  }

  _buildTermsAndPolicy(BuildContext context, ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          Text(
            "By continuing you agree to our ",
            style: theme.textTheme.bodySmall,
          ),
          GestureDetector(
            onTap: () {
              appNavigation(context, const PrivacyPolicyPage());
            },
            child: Text(
              "Privacy Policy",
              style: theme.textTheme.bodySmall!.copyWith(
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
          registerBloc.add(
            RegisterNewEvent(
              email: emailTextEditingController.text,
              username: userNameTextEditingController.text,
              password: passwordTextEditingController.text,
              rePassword: confirmPasswordTextEditingController.text,
            ),
          );
        },
      );
}
