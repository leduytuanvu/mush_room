import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/extensions/exception/exception.dart';
import 'package:mush_room/features/device/notification/bloc/notification_event.dart';
import 'package:mush_room/features/device/notification/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitialState());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is NotificationRefreshEvent) {
      try {
        yield NotificationLoadingState();
        await Future.delayed(const Duration(seconds: 2));
        yield NotificationSuccessState();
      } on DioError catch (error) {
        error.showDialogDioException();
        yield NotificationInitialState();
      } catch (error) {
        error.toString().showDialogCatchException(error.toString());
        yield NotificationInitialState();
      }
    }
  }
}
