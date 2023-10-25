import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
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
  final registerBloc = injector<RegisterBloc>();
  final TextEditingController userNameText = TextEditingController();
  final TextEditingController emailText = TextEditingController();
  final TextEditingController phoneText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final TextEditingController confirmPasswordText = TextEditingController();

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
          appBar: _buildAppBar(context),
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

  _buildAppBar(BuildContext context) => AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            registerBloc.add(ResetRegisterEvent());
          },
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
                  textEditingController: emailText,
                  errorText: ((state is RegisterErrorSubmittedState) &&
                          (state.emailError.isNotEmpty))
                      ? state.emailError
                      : null,
                  node: _node,
                ),
                const SizedBox(height: 6),
                MushRoomTextFieldWidget(
                  labelText: "Username",
                  textEditingController: userNameText,
                  errorText: ((state is RegisterErrorSubmittedState) &&
                          (state.nameError.isNotEmpty))
                      ? state.nameError
                      : null,
                  node: _node,
                ),
                const SizedBox(height: 6),
                MushRoomTextFieldWidget(
                  labelText: "Phone number",
                  textEditingController: phoneText,
                  errorText: ((state is RegisterErrorSubmittedState) &&
                          (state.phoneNumberError.isNotEmpty))
                      ? state.phoneNumberError
                      : null,
                  node: _node,
                ),
                const SizedBox(height: 6),
                MushRoomTextFieldWidget(
                  labelText: "Password",
                  textEditingController: passwordText,
                  errorText: ((state is RegisterErrorSubmittedState) &&
                          (state.passwordError.isNotEmpty))
                      ? state.passwordError
                      : null,
                  hidden: true,
                  node: _node,
                ),
                const SizedBox(height: 6),
                MushRoomTextFieldWidget(
                  labelText: "Confirm password",
                  textEditingController: confirmPasswordText,
                  errorText: ((state is RegisterErrorSubmittedState) &&
                          (state.rePasswordError.isNotEmpty))
                      ? state.rePasswordError
                      : null,
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
      alignment: Alignment.center,
      child: Wrap(
        children: [
          Text(
            "By continuing you agree to our ",
            style: theme.textTheme.bodySmall,
          ),
          GestureDetector(
            onTap: () {
              appNavigation(const PrivacyPolicyPage());
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
            RegisterSubmittedEvent(
              email: emailText.text,
              name: userNameText.text,
              phoneNumber: phoneText.text,
              password: passwordText.text,
              rePassword: confirmPasswordText.text,
            ),
          );
        },
      );
}
