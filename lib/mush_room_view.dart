import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/utils/app_localizations.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/authentication/login/ui/pages/login_page.dart';
import 'package:mush_room/features/onboarding/ui/pages/onboarding_page.dart';
import 'package:mush_room/features/splash/ui/pages/splash_page.dart';

class MushRoomView extends StatelessWidget {
  const MushRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return MaterialApp(
          locale: state.locale,
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
          theme: context.select((ThemeBloc bloc) => bloc.state.themeData),
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('vi', ''),
          ],
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
