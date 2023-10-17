import 'package:get_it/get_it.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt injector = GetIt.instance;

Future<void> setupInjector() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  injector.registerSingleton<DioClient>(DioClient());
  injector.registerLazySingleton(() => ThemeBloc(injector()));
  injector.registerLazySingleton(() => LocalizationBloc(injector()));
  injector.registerLazySingleton(() => SharedPreferenceService(sharedPreferences));
}
