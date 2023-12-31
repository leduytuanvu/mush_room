import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/blocs/network/network_bloc.dart';
import 'package:mush_room/core/blocs/network/network_event.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/mqtt/mqtt_publish.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/core/utils/app_localizations.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/splash/ui/pages/splash_page.dart';

class MushRoomView extends StatefulWidget {
  const MushRoomView({Key? key}) : super(key: key);

  @override
  State<MushRoomView> createState() => _MushRoomViewState();
}

class _MushRoomViewState extends State<MushRoomView> {
  @override
  void initState() {
    context.read<NetworkBloc>().add(NetworkObserve());
    MqttPublishFunc.instance.startListenMqtt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return MaterialApp(
          locale: state.locale,
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          theme: context.select((ThemeBloc bloc) => bloc.state.themeData),
          localizationsDelegates: localizations,
          supportedLocales: languages,
          navigatorKey: NavigationService().navigationKey,
          navigatorObservers: [AppRouter.routeObserver],
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}

Iterable<LocalizationsDelegate<dynamic>>? localizations = const [
  AppLocalizationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

Iterable<Locale> languages = const [
  Locale('en', ''),
  Locale('vi', ''),
];
