import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/features/profile/bloc/infor_profile/infor_profile_bloc.dart';
import 'package:mush_room/features/profile/bloc/infor_profile/infor_profile_event.dart';
import 'package:mush_room/features/profile/bloc/infor_profile/infor_profile_state.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/loading/mush_room_loading_widget.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';

class ChangeInforProfilePage extends StatelessWidget {
  final String title;
  final String value;
  final bool isPassword;
  final bool isUserName;

  ChangeInforProfilePage({
    super.key,
    required this.title,
    required this.value,
    this.isPassword = false,
    this.isUserName = false,
  });

  final FocusScopeNode node = FocusScopeNode();
  final inforProfileBloc = injector<InforProfileBloc>();
  final shared = injector<SharedPreferenceService>();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController newPassTextEditingController = TextEditingController();
  TextEditingController confirmPassTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    !isPassword
        ? textEditingController.text = value
        : textEditingController.text = "";
    final theme = Theme.of(context);
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(theme, context),
          body: _buildBody(theme, context),
        ),
        // MushRoomLoadingWidget(),
        BlocBuilder<InforProfileBloc, InforProfileState>(
            bloc: inforProfileBloc, // Using bottomBarBloc directly
            builder: (context, state) {
              if (state is InforProfileLoadingState) {
                return const MushRoomLoadingWidget();
              } else {
                return const SizedBox.shrink();
              }
            })
      ],
    );
  }

  _buildAppBar(ThemeData theme, BuildContext context) => AppBar(
        title: Text(
          " Change ${title.toLowerCase()}",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            inforProfileBloc.add(ResetInforProfileEvent());
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildBody(ThemeData theme, BuildContext context) => Padding(
        padding: const EdgeInsets.all(26.0),
        child: BlocBuilder<InforProfileBloc, InforProfileState>(
            bloc: inforProfileBloc,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  MushRoomTextFieldWidget(
                    labelText: !isPassword ? title : "Old password",
                    textEditingController: textEditingController,
                    hidden: isPassword ? true : false,
                    errorText: (state is InforProfileSubmittedUpdateUserState)
                        ? (state.usernameErrorMessage.isEmpty
                            ? state.phoneErrorMessage
                            : state.usernameErrorMessage)
                        : (state is InforProfileSubmittedUpdatePasswordState
                            ? (state.oldPasswordErrorMessage.isEmpty
                                ? null
                                : state.oldPasswordErrorMessage)
                            : null),
                    node: node,
                    hintText: "Enter ${title.toLowerCase()}",
                  ),
                  isPassword
                      ? MushRoomTextFieldWidget(
                          labelText: "New password",
                          textEditingController: newPassTextEditingController,
                          hidden: true,
                          errorText:
                              (state is InforProfileSubmittedUpdatePasswordState
                                  ? (state.newPasswordErrorMessage.isEmpty
                                      ? null
                                      : state.newPasswordErrorMessage)
                                  : null),
                          node: node,
                          hintText: "Enter new ${title.toLowerCase()}",
                        )
                      : const SizedBox.shrink(),
                  isPassword
                      ? MushRoomTextFieldWidget(
                          labelText: "Comfirm password",
                          textEditingController:
                              confirmPassTextEditingController,
                          hidden: true,
                          errorText:
                              (state is InforProfileSubmittedUpdatePasswordState
                                  ? (state.confirmPasswordErrorMessage.isEmpty
                                      ? null
                                      : state.confirmPasswordErrorMessage)
                                  : null),
                          node: node,
                          hintText: "Enter confirm ${title.toLowerCase()}",
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 6),
                  MushRoomButtonWidget(
                    label: "Save",
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (isPassword) {
                        inforProfileBloc.add(
                          InforProfileUpdatePasswordEvent(
                            oldPassword: textEditingController.text,
                            newPassword: newPassTextEditingController.text,
                            confirmPassword:
                                confirmPassTextEditingController.text,
                          ),
                        );
                      } else {
                        inforProfileBloc.add(
                          InforProfileUpdateUserEvent(
                            username: isUserName
                                ? textEditingController.text
                                : shared.getUsername(),
                            phone: !isUserName
                                ? textEditingController.text
                                : shared.getPhone(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            }),
      );
}
