import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';
import 'package:mush_room/features/splash/bloc/splash_bloc.dart';
=======
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/utils/app_localizations.dart';
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';
import 'package:mush_room/features/splash/bloc/splash_bloc.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/mush_room_button_widget.dart';
import 'package:sizer/sizer.dart';
>>>>>>> master

// class SplashPage extends StatelessWidget {
//   const SplashPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context).hello, style: textTheme.titleSmall,),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             MushRoomButtonWidget(
//               label: "Light mode",
//               onPressed: () {
//                 context.read<ThemeBloc>().add(ThemeLightModeEnabled());
//               },
//             ),
//
//             MushRoomButtonWidget(
//               label: "Dark Mode",
//               onPressed: () {
//                 context.read<ThemeBloc>().add(ThemeDarkModeEnabled());
//               },
//               paddingHorizontal: 20,
//               paddingVertical: 20,
//             ),
//
//             MushRoomButtonWidget(
//               label: "Switch to English",
//               onPressed: () {
//                 context.read<LocalizationBloc>().add(LocalizationUpdated(const Locale('en')));
//               },
//               paddingAll: 10.0,
//             ),
//
//             MushRoomButtonWidget(
//               label: "Switch to Vietnamese",
//               onPressed: () {
//                 context.read<LocalizationBloc>().add(LocalizationUpdated(const Locale('vi')));
//               },
//               paddingTop: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(InitializeSplash()),
      // Assuming InitializeSplash is the event to start the timer
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToBottomBar) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const BottomBarPage()));
          }
        },
        child: _buildScaffold(),
      ),
    );
  }

  _buildScaffold() => Scaffold(
        body: _buildBody(),
      );

  _buildBody() => Container(
    color: const Color(0xff53B175),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(width: 100.w,),
            _buildLogo(),
            const SizedBox(height: 64,),
            _buildCircleLoading(),
          ],
        ),
  );

  _buildLogo() => Assets.icons.iconLogoApp.image(
      width: (50.w > 200) ? 300 : 50.w, height: (50.w > 200) ? 300 : 50.w);

  _buildCircleLoading() => LoadingAnimationWidget.hexagonDots(
    color: Colors.black,
    size: 50,
  );
}
