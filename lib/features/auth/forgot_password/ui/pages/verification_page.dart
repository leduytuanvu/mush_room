import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_bloc.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_state.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  _buildScaffold(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final verificationBloc = injector<VerificationBloc>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: _buildAppBar(),
          body: _buildBody(context, textTheme, verificationBloc),
        ),
        BlocBuilder<VerificationBloc, VerificationState>(
          bloc: verificationBloc,
          builder: (context, state) {
            if (state is VerificationLoadingState) {
              FocusScope.of(context).unfocus();
              return _buildLoading();
            }
            // else if (state is VerificationSuccessState) {
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     appNavigation(context, const LoginPage(), isRemoveAll: true);
            //   });
            //   return const SizedBox.shrink();
            // }
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

  _buildBody(
    BuildContext context,
    TextTheme textTheme,
    VerificationBloc verificationBloc,
  ) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FocusScopeNode node = FocusScopeNode();

    TextEditingController verificationTextEditingController =
        TextEditingController();
    TextEditingController passwordTextEditingController =
        TextEditingController();
    TextEditingController rePasswordTextEditingController =
        TextEditingController();

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            const SizedBox(height: 6),
            _buildTitle(textTheme),
            const SizedBox(height: 20),
            _buildFormInput(
              verificationBloc,
              textTheme,
              formKey,
              node,
              verificationTextEditingController,
              passwordTextEditingController,
              rePasswordTextEditingController,
            ),
            const SizedBox(height: 20),
            _buildButtonResetPassword(
              verificationBloc,
              verificationTextEditingController,
              passwordTextEditingController,
              rePasswordTextEditingController,
            ),
          ],
        ),
      ),
    );
  }

  _buildTitle(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Verification",
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          "The verification code has been sent to your email, enter the verification code below and reset your password",
          style: textTheme.bodySmall!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

  _buildFormInput(
    VerificationBloc verificationBloc,
    TextTheme textTheme,
    Key formKey,
    FocusScopeNode node,
    TextEditingController verificationTextEditingController,
    TextEditingController passwordTextEditingController,
    TextEditingController rePasswordTextEditingController,
  ) {
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
                  node: node,
                  hintText: "Enter verification code",
                ),
                const SizedBox(height: 6),
                if (state is VerificationErrorState) ...[
                  if (state.codeError.isNotEmpty)
                    _buildErrorMessage(state.codeError, textTheme),
                ],
                const SizedBox(height: 12),
                MushRoomTextFieldWidget(
                  labelText: "New password",
                  textEditingController: passwordTextEditingController,
                  node: node,
                  hintText: "Enter your new password",
                ),
                const SizedBox(height: 6),
                if (state is VerificationErrorState) ...[
                  if (state.passwordError.isNotEmpty)
                    _buildErrorMessage(state.passwordError, textTheme),
                ],
                const SizedBox(height: 12),
                MushRoomTextFieldWidget(
                  labelText: "Re-new password",
                  textEditingController: rePasswordTextEditingController,
                  node: node,
                  hintText: "Enter your re-new password",
                ),
                const SizedBox(height: 6),
                if (state is VerificationErrorState) ...[
                  if (state.rePasswordError.isNotEmpty)
                    _buildErrorMessage(state.rePasswordError, textTheme),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  _buildErrorMessage(String text, TextTheme textTheme) {
    return Text(
      text,
      style: textTheme.displaySmall,
    );
  }

  _buildButtonResetPassword(
    VerificationBloc verificationBloc,
    TextEditingController verificationTextEditingController,
    TextEditingController passwordTextEditingController,
    TextEditingController rePasswordTextEditingController,
  ) {
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
