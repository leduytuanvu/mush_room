import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/blocs/app_bloc/app_bloc.dart';
import 'package:mush_room/mush_room_view.dart';
import 'package:sizer/sizer.dart';

class MushRoomApp extends StatelessWidget {
  const MushRoomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: AppBloc.providers,
        child: const MushRoomView(),
      );
    });
  }
}
