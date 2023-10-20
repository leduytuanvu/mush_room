import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<ItemManageModel> listItemManage = [
    ItemManageModel(
        iconPath: Assets.icons.iconBell.path, content: "My information"),
    ItemManageModel(
        iconPath: Assets.icons.iconBell.path, content: "Notifecations"),
    ItemManageModel(iconPath: Assets.icons.iconBell.path, content: "Help"),
    ItemManageModel(iconPath: Assets.icons.iconBell.path, content: "About"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Le Duy Tuan Vu",
                          style: AppTextStyle.bodyTextStyleH3(),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            print("edit");
                          },
                          child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.edit,
                                size: 15,
                              )),
                        )
                      ],
                    ),
                    Text(
                      "leduytuanvu.work@gmail.com",
                      style: AppTextStyle.smailText(),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          _buildListItem(),
          const Divider(
            color: Colors.grey,
          ),
          Spacer(),
          _buildLogOutButton(),
        ],
      ),
    );
  }

  _buildListItem() => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return _buildItem(
              iconPath: listItemManage[index].iconPath,
              content: listItemManage[index].content,
              onTap: listItemManage[index].onTap);
        },
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
        ),
        itemCount: listItemManage.length,
      );

  _buildItem(
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
                  style: AppTextStyle.bodyTextStyleH3(),
                ),
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      );

  _buildLogOutButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: MushRoomButtonWidget(
          label: "Log Out",
          onPressed: () {},
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
