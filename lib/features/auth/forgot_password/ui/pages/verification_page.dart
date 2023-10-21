import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_bloc.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_state.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/loading/mush_room_loading_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({Key? key}) : super(key: key);
  final verificationBloc = injector<VerificationBloc>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusScopeNode node = FocusScopeNode();
  TextEditingController verificationTextEditingController =
  TextEditingController();
  TextEditingController passwordTextEditingController =
  TextEditingController();
  TextEditingController rePasswordTextEditingController =
  TextEditingController();

  Future<bool> _onWillPop(BuildContext context) async {
    final state = verificationBloc.state;
    if (state is VerificationLoadingState) {
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
          body: _buildBody(theme),
        ),
        BlocBuilder<VerificationBloc, VerificationState>(
          bloc: verificationBloc,
          builder: (context, state) {
            if (state is VerificationLoadingState) {
              FocusScope.of(context).unfocus();
              return const MushRoomLoadingWidget();
            }
            else {
              return const SizedBox.shrink();
            }
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

  _buildBody(ThemeData theme) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            const SizedBox(height: 6),
            _buildTitle(theme),
            const SizedBox(height: 20),
            _buildFormInput(),
            const SizedBox(height: 16),
            _buildButtonResetPassword(),
          ],
        ),
      ),
    );
  }

  _buildTitle(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Verification",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          "The verification code has been sent to your email, enter the verification code below and reset your password",
          style: theme.textTheme.bodySmall!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

  _buildFormInput() {
    return Form(
      key: formKey,
      child: FocusScope(
        node: node,
        child: BlocBuilder<VerificationBloc, VerificationState>(
          bloc: verificationBloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MushRoomTextFieldWidget(
                  labelText: "Verification code",
                  textEditingController: verificationTextEditingController,
                  errorText: ((state is VerificationErrorState) &&
                      (state.codeError.isNotEmpty)) ? state
                      .codeError : null,
                  node: node,
                  hintText: "Enter verification code",
                ),
                const SizedBox(height: 6),
                MushRoomTextFieldWidget(
                  labelText: "New password",
                  textEditingController: passwordTextEditingController,
                  errorText: ((state is VerificationErrorState) &&
                      (state.passwordError.isNotEmpty)) ? state
                      .passwordError : null,
                  node: node,
                  hintText: "Enter your new password",
                ),
                const SizedBox(height: 6),
                MushRoomTextFieldWidget(
                  labelText: "Re-new password",
                  textEditingController: rePasswordTextEditingController,
                  errorText: ((state is VerificationErrorState) &&
                      (state.rePasswordError.isNotEmpty)) ? state
                      .rePasswordError : null,
                  node: node,
                  hintText: "Enter your re-new password",
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildButtonResetPassword() {
    return MushRoomButtonWidget(
      label: "Reset Password",
      onPressed: () {
        verificationBloc.add(
          ResetPasswordEvent(
            verificationCode: verificationTextEditingController.text,
            newPassword: passwordTextEditingController.text,
            reNewPassword: rePasswordTextEditingController.text,
          ),
        );
      },
    );
  }
}
