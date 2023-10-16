import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/utils/app_localizations.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).hello),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (

              ) {
                context.read<ThemeBloc>().add(ThemeLightModeEnabled());
              },
              child: const Text('Light Mode'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ThemeDarkModeEnabled());
              },
              child: const Text('Dark Mode'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LocalizationBloc>().add(LocalizationUpdated(const Locale('en')));
              },
              child: const Text('Switch to English'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LocalizationBloc>().add(LocalizationUpdated(const Locale('es')));
              },
              child: const Text('Switch to Spanish'),
            ),
          ],
        ),
      ),
    );
  }
}