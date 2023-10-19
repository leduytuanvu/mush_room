import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/mush_room_view.dart';
import 'package:sizer/sizer.dart';

class MushRoomApp extends StatelessWidget {
  const MushRoomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BlocProvider> providers = [
      BlocProvider<ThemeBloc>(create: (context) => injector<ThemeBloc>()),
      BlocProvider<LocalizationBloc>(
          create: (context) => injector<LocalizationBloc>()),
    ];

    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: providers,
        child: const MushRoomView(),
      );
    });
  }
}
