import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/features/profile/bloc/infor_profile/infor_profile_bloc.dart';
import 'package:mush_room/features/profile/bloc/infor_profile/infor_profile_state.dart';
import 'package:mush_room/features/profile/ui/pages/change_infor_page.dart';
import 'package:mush_room/gen/assets.gen.dart';

class InforProfilePage extends StatelessWidget {
  InforProfilePage({super.key});

  final List<ItemManageModel> listItemManage = [
    ItemManageModel(
        iconPath: Assets.icons.iconBell.path, content: "My information"),
    ItemManageModel(
        iconPath: Assets.icons.iconBell.path, content: "Notifications"),
  ];

  final shared = injector<SharedPreferenceService>();
  final inforProfileBloc = injector<InforProfileBloc>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pink,
                        ),
                        height: 100,
                        width: 100,
                        child: Assets.icons.iconProfile
                            .image(width: 50, height: 50),
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Text(
                  //   shared.getUsername(),
                  //   style: AppTextStyle.bodyTextStyleH3(),
                  // ),
                  // SizedBox(height: 4),
                  // Text(
                  //   shared.getEmail(),
                  //   style: AppTextStyle.smallTextStyle(),
                  // ),
                  BlocBuilder<InforProfileBloc, InforProfileState>(
                      bloc: inforProfileBloc, // Using bottomBarBloc directly
                      builder: (context, state) {
                        if (state is InforProfileUpdateSuccessState ||
                            state is InforProfileInitialState) {
                          return Column(
                            children: [
                              Text(
                                shared.getUsername(),
                                style: AppTextStyle.bodyTextStyleH3(),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                shared.getEmail(),
                                style: AppTextStyle.smallTextStyle(),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      })
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildItem(
            context,
            content: "Username",
            isUsername: true,
            onTap: () {
              appNavigation(
                ChangeInforProfilePage(
                  title: "Username",
                  value: shared.getUsername(),
                  isUserName: true,
                ),
              );
            },
          ),
          _buildItem(context,
              content: "Email", isEmail: true, canChange: false),
          _buildItem(
            context,
            content: "Phone",
            isPhone: true,
            onTap: () {
              appNavigation(ChangeInforProfilePage(
                title: "Phone",
                value: shared.getPhone(),
              ));
            },
          ),
          _buildItem(context, content: "Password", onTap: () {
            appNavigation(ChangeInforProfilePage(
              title: "Password",
              value: "",
              isPassword: true,
            ));
          }),
        ],
      ),
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      );

  _buildItem(BuildContext context,
          {required String content,
          bool canChange = true,
          bool isUsername = false,
          bool isEmail = false,
          bool isPhone = false,
          void Function()? onTap}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              content,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                BlocBuilder<InforProfileBloc, InforProfileState>(
                    bloc: inforProfileBloc, // Using bottomBarBloc directly
                    builder: (context, state) {
                      if (state is InforProfileUpdateSuccessState ||
                          state is InforProfileInitialState) {
                        return Text(
                          isPhone
                              ? shared.getPhone()
                              : ((isUsername
                                  ? shared.getUsername()
                                  : (isEmail
                                      ? shared.getEmail()
                                      : "*********"))),
                          style: AppTextStyle.smallTextStyle(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                const Spacer(),
                canChange
                    ? GestureDetector(
                        onTap: onTap,
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.black54,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 10),
            const Divider()
          ],
        ),
      );
}

class ItemManageModel {
  final String iconPath;
  final String content;
  void Function()? onTap;

  ItemManageModel({
    required this.iconPath,
    required this.content,
    this.onTap,
  });
}
