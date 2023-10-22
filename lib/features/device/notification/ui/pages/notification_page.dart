import 'package:flutter/material.dart';
import 'package:mush_room/features/device/notification/ui/widgets/item_notification_widget.dart';
import 'package:mush_room/shared/widgets/dialog/mush_room_dialog_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ItemNotificationWidget(),
              ItemNotificationWidget(),
              ItemNotificationWidget(),
              ItemNotificationWidget(),
              ItemNotificationWidget(),
              ItemNotificationWidget(),
              ItemNotificationWidget(),
              ItemNotificationWidget(),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
    title: Text(" Notification", style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    centerTitle: true,
  );

  _buildTitle(ThemeData theme) => Text(
    "Privacy Policy",
    style: theme.textTheme.titleLarge,
  );
}
