import 'package:get_it/get_it.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/environments/config_manager.dart';
import 'package:mush_room/core/network/auth_interceptor.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/repositories/user_repository.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt injector = GetIt.instance;

Future<void> setupInjector() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final dioClient = DioClient();

  // Dio
  injector.registerSingleton<DioClient>(dioClient);
  injector.registerSingleton<AuthInterceptor>(AuthInterceptor());

  // Bloc
  injector.registerLazySingleton(() => ThemeBloc(injector()));
  injector.registerLazySingleton(() => LocalizationBloc(injector()));

  // Service
  injector.registerLazySingleton(() => SharedPreferenceService(sharedPreferences));

  // Repository
  injector.registerLazySingleton(() => UserRepository(dioClient));
  injector.registerLazySingleton(() => AuthRepository(dioClient));
}
