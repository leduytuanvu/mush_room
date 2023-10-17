import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/environments/config_manager.dart';
import 'package:mush_room/core/utils/app_error_handler.dart';
import 'package:mush_room/mush_room_app.dart';
import 'package:mush_room/core/utils/app_bloc_observer.dart';

Future<void> main() async {
    await runZonedGuarded(() async {
        FlutterError.onError = (FlutterErrorDetails details) {
          AppErrorHandler.handleException(details.exception, details.stack);
        };
        // Ensure flutter binding
        WidgetsFlutterBinding.ensureInitialized();
        // Set up environment
        ConfigManager.setEnvironment(Environment.dev);
        // Set up injector
        await setupInjector();
        // Set up bloc observer
        Bloc.observer = AppBlocObserver();
        // Run app
        runApp(const MushRoomApp());
    }, (error, stackTrace) {
        AppErrorHandler.handleException(error, stackTrace);
    });
}

