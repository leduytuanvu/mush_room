import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/profile/ui/pages/frequently_question_page.dart';
import 'package:mush_room/features/profile/ui/pages/set_up_device_manual_page.dart';

class UserManualPage extends StatelessWidget {
  const UserManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: _buildBody(theme),
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
        title: Text(
          " User Manual",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildBody(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        _buildItem("Set up device", theme, () {
          appNavigation(SetUpDeviceManualPage());
        }),
        const Divider(),
        _buildItem("Frequently asked questions", theme, () {
          appNavigation(const FrequentlyQuestionPage());
        }),
      ],
    );
  }

  _buildItem(String title, ThemeData theme, Function() function) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        child: Row(
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
