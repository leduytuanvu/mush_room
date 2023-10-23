import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';
import 'package:mush_room/features/splash/bloc/splash_bloc.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(InitializeSplash()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToBottomBarState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => BottomBarPage()),
            );
          } else if(state is SplashNavigateToLoginState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => LoginPage()),
            );
          }
        },
        child: _buildScaffold(),
      ),
    );
  }

  _buildScaffold() => Scaffold(body: _buildBody());

  _buildBody() => Container(
        color: const Color(0xff53B175),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: 100),
            _buildCircleLoading(),
            const SizedBox(height: 80),
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
