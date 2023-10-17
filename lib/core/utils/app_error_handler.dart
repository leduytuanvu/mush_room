import 'package:mush_room/core/utils/app_logger.dart';

class AppErrorHandler {
  static void handleException(dynamic error, [StackTrace? stackTrace]) {
    AppLogger.e('Error: $error');
    if (stackTrace != null) {
      AppLogger.e(stackTrace.toString());
    }
  }
}