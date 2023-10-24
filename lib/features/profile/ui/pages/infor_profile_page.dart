import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 4),
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
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Le Duy Tuan Vu",
                    style: AppTextStyle.bodyTextStyleH3(),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "leduytuanvu.work@gmail.com",
                    style: AppTextStyle.smallTextStyle(),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildItem(context, content: "Username", value: "leduytuanvu",
              onTap: () {
            appNavigation(ChangeInforProfilePage(
                title: "Username", value: "leduytuanvu"));
          }),
          _buildItem(context,
              content: "Email",
              value: "leduytuanvu.work@gmail.com",
              canChange: false),
          _buildItem(context, content: "Phone", value: "0961181732", onTap: () {
            appNavigation(ChangeInforProfilePage(
              title: "Email",
              value: "leduytuanvu.work@gmail.com",
            ));
          }),
          _buildItem(context, content: "Password", value: "***********",
              onTap: () {
            appNavigation(ChangeInforProfilePage(
              title: "Password",
              value: "leduytuanvu",
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
          required String value,
          bool canChange = true,
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
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  value,
                  style: AppTextStyle.smallTextStyle(),
                ),
                Spacer(),
                canChange
                    ? GestureDetector(
                        onTap: onTap,
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.black54,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 10),
            Divider()
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
