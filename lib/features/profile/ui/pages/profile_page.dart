

import 'package:flutter/material.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_event.dart';
import 'package:mush_room/features/profile/bloc/profile_bloc.dart';
import 'package:mush_room/features/profile/bloc/profile_event.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<ItemManageModel> listItemManage = [
    ItemManageModel(
        iconPath: Assets.icons.iconBell.path, content: "My information"),
    ItemManageModel(
        iconPath: Assets.icons.iconBell.path, content: "Notifications"),
    ItemManageModel(iconPath: Assets.icons.iconBell.path, content: "Help"),
    ItemManageModel(iconPath: Assets.icons.iconBell.path, content: "About"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink,
                    ),
                    height: 70,
                    width: 70,
                    child: Assets.icons.iconProfile.image(width: 50, height: 50),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Le Duy Tuan Vu",
                        style: AppTextStyle.bodyTextStyleH3(),
                      ),
                      Text(
                        "leduytuanvu.work@gmail.com",
                        style: AppTextStyle.smallTextStyle(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            _buildListItem(context),
            const Divider(
              color: Colors.grey,
            ),
            const Spacer(),
            _buildLogOutButton(context),

          ],
        ),
      ),
    );
  }

  _buildListItem(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return _buildItem(
            context,
              iconPath: listItemManage[index].iconPath,
              content: listItemManage[index].content,
              onTap: listItemManage[index].onTap);
        },
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
        ),
        itemCount: listItemManage.length,
      );

  _buildItem(BuildContext context,
          {required String iconPath,
          required String content,
          void Function()? onTap}) =>
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Row(
            children: [
              Image.asset(iconPath, width: 20, height: 20),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18,)
            ],
          ),
        ),
      );

  _buildLogOutButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: MushRoomButtonWidget(
          label: "Log Out",
          onPressed: () {
            // final shared = injector<SharedPreferenceService>();
            final profileBloc = injector<ProfileBloc>();
            profileBloc.add(ShowLogoutProfileEvent());
            // bottomBarBloc.add(ResetBottomBarEvent());
            // shared.clearUser();
            // appNavigation(context, LoginPage(), isRemoveAll: true);
          },
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
