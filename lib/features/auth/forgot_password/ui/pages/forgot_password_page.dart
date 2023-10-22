import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_state.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/verification_page.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/loading/mush_room_loading_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);
  final forgotPasswordBloc = injector<ForgotPasswordBloc>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusScopeNode node = FocusScopeNode();
  TextEditingController emailTextEditingController = TextEditingController();

  Future<bool> _onWillPop(BuildContext context) async {
    final state = forgotPasswordBloc.state;
    if (state is ForgotPasswordLoadingState) {
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
          body: _buildBody(theme),
        ),
        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          bloc: forgotPasswordBloc,
          builder: (context, state) {
            if (state is ForgotPasswordLoadingState) {
              FocusScope.of(context).unfocus();
              return const MushRoomLoadingWidget();
            } else {
              return const SizedBox.shrink();
            }
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            forgotPasswordBloc.add(ResetForgotPasswordEvent());
          },
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
            const SizedBox(height: 26),
            _buildFormInput(),
            const SizedBox(height: 16),
            _buildButtonSendVerification(),
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
          "Forgot Password",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          "Enter your email to receive the verification code",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              bloc: forgotPasswordBloc,
              builder: (context, state) {
                if(state is ForgotPasswordSuccessState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      appNavigation(context, VerificationPage());
                    });
                    forgotPasswordBloc.add(ResetForgotPasswordEvent());
                    return const SizedBox.shrink();
                } else {
                  return MushRoomTextFieldWidget(
                    labelText: "Email",
                    textEditingController: emailTextEditingController,
                    errorText: ((state is ForgotPasswordErrorState) &&
                        (state.emailErrorMessage.isNotEmpty)) ? state
                        .emailErrorMessage : null,
                    node: node,
                    hintText: "Enter your email",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildButtonSendVerification() =>
      MushRoomButtonWidget(
        label: "Send Verification",
        onPressed: () {
          forgotPasswordBloc.add(
            SendVerificationEvent(
              email: emailTextEditingController.text,
            ),
          );
        },
      );
}
