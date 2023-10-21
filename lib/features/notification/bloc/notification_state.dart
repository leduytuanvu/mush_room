import 'package:equatable/equatable.dart';
import 'package:mush_room/core/models/notification/notification_model.dart';

abstract class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationErrorState extends NotificationState {
  final List<NotificationModel> listNotification;

  NotificationErrorState({
    this.listNotification = List<NotificationModel>();
  });
}

class NotificationSuccessState extends NotificationState {}
