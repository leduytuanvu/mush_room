import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/features/device/notification/bloc/notification_bloc.dart';
import 'package:mush_room/features/device/notification/bloc/notification_event.dart';
import 'package:mush_room/features/device/notification/bloc/notification_state.dart';
import 'package:mush_room/features/device/notification/ui/widgets/item_notification_widget.dart';
import 'package:mush_room/shared/widgets/loading/mush_room_loading_widget.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final notificationBloc = injector<NotificationBloc>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _handleRefresh() async {
    // Implement your refresh logic here.
    // You can fetch new data or perform any other refresh action.
    // For example, you can call an API to get the latest notifications.
    notificationBloc.add(NotificationRefreshEvent()); // Simulating a delay
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(theme),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            child: Padding(
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
          ),
        ),
        BlocBuilder<NotificationBloc, NotificationState>(
            bloc: notificationBloc, // Using bottomBarBloc directly
            builder: (context, state) {
              if (state is NotificationLoadingState) {
                return MushRoomLoadingWidget();
              } else {
                return const SizedBox.shrink();
              }
            })
      ],
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
        title: Text(
          " Notification",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
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
