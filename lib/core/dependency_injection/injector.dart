import 'package:get_it/get_it.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/network/auth_interceptor.dart';
import 'package:mush_room/core/network/dio_client.dart';
import 'package:mush_room/core/repositories/auth_repository.dart';
import 'package:mush_room/core/repositories/user_repository.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:mush_room/features/auth/forgot_password/bloc/verification/verification_bloc.dart';
import 'package:mush_room/features/auth/login/bloc/login_bloc.dart';
import 'package:mush_room/features/auth/register/bloc/register_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_bloc.dart';
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
  injector.registerLazySingleton(() => BottomBarBloc());
  injector.registerLazySingleton(() => ScanQrCodeBloc());
  injector.registerLazySingleton(() => RegisterBloc());
  injector.registerLazySingleton(() => LoginBloc(injector()));
  injector.registerLazySingleton(() => VerificationBloc());
  injector.registerLazySingleton(() => ForgotPasswordBloc());

  // Service
  injector
      .registerLazySingleton(() => SharedPreferenceService(sharedPreferences));

  // Repository
  injector.registerLazySingleton(() => UserRepository(dioClient));
  injector.registerLazySingleton(() => AuthRepository(dioClient));
}
