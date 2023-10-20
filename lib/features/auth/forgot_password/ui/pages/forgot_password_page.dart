import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_event.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_state.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/verification_page.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  Future<bool> _onWillPop(
    BuildContext context,
    ForgotPasswordBloc forgotPasswordBloc,
  ) async {
    final state = forgotPasswordBloc.state;
    if (state is ForgotPasswordLoadingState) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordBloc = injector<ForgotPasswordBloc>();
    return WillPopScope(
      onWillPop: () => _onWillPop(context, forgotPasswordBloc),
      child: _buildScaffold(context, forgotPasswordBloc),
    );
  }

  _buildScaffold(
    BuildContext context,
    ForgotPasswordBloc forgotPasswordBloc,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final forgotPasswordBloc = injector<ForgotPasswordBloc>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: _buildAppBar(),
          body: _buildBody(context, textTheme, forgotPasswordBloc),
        ),
        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          bloc: forgotPasswordBloc,
          builder: (context, state) {
            if (state is ForgotPasswordLoadingState) {
              FocusScope.of(context).unfocus();
              return _buildLoading();
            } else {
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
    ForgotPasswordBloc forgotPasswordBloc,
  ) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FocusScopeNode node = FocusScopeNode();

    TextEditingController emailTextEditingController = TextEditingController();

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            const SizedBox(height: 6),
            _buildTitle(context),
            const SizedBox(height: 20),
            _buildFormInput(
              context,
              forgotPasswordBloc,
              textTheme,
              formKey,
              node,
              emailTextEditingController,
            ),
            const SizedBox(height: 20),
            _buildButtonSendVerification(
              context,
              forgotPasswordBloc,
              emailTextEditingController,
            ),
          ],
        ),
      ),
    );
  }

  _buildTitle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Forgot Password",
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          "Enter your email to receive the verification code",
          style: textTheme.bodySmall!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

  _buildFormInput(
    BuildContext context,
    ForgotPasswordBloc forgotPasswordBloc,
    TextTheme textTheme,
    Key formKey,
    FocusScopeNode node,
    TextEditingController emailTextEditingController,
  ) {
    return Form(
      key: formKey,
      child: FocusScope(
        node: node,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MushRoomTextFieldWidget(
              labelText: "Email",
              textEditingController: emailTextEditingController,
              node: node,
              hintText: "Enter your email",
            ),
            const SizedBox(height: 6),
            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              bloc: forgotPasswordBloc,
              builder: (context, state) {
                if (state is ForgotPasswordErrorState) {
                  if (state.emailErrorMessage.isNotEmpty) {
                    return _buildErrorMessage(
                        state.emailErrorMessage, textTheme);
                  } else {
                    return const SizedBox.shrink();
                  }
                } else if (state is ForgotPasswordSuccessState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    appNavigation(context, const VerificationPage());
                  });
                  return const SizedBox.shrink();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
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

  _buildButtonSendVerification(
    BuildContext context,
    ForgotPasswordBloc forgotPasswordBloc,
    TextEditingController verificationTextEditingController,
  ) =>
      MushRoomButtonWidget(
        label: "Send Verification",
        onPressed: () {
          forgotPasswordBloc.add(
            SendVerificationEvent(
              emailErrorMessage: verificationTextEditingController.text,
            ),
          );
        },
      );

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
