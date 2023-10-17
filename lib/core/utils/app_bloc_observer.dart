import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/utils/app_logger.dart';

class AppBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.i('Event: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.e('Error: $error');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.i('Transition: $transition');
  }
}