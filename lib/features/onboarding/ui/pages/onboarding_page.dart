import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/gen/assets.gen.dart';

import '../../../../shared/widgets/button/mush_room_button_widget.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() => Scaffold(
        body: _buildBody(),
      );

  _buildBody() => Stack(
        fit: StackFit.expand, // Make the Stack fill the entire screen
        children: <Widget>[
          // Background Image
          Assets.images.onboarding1.image(fit: BoxFit.cover),
          _buildContent(),
        ],
      );

  Widget _buildContent() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Welcome to Mush Room",
              textAlign: TextAlign.center,
              // style:
              //     AppTextStyle.normalTextStyle(color: Colors.white, size: 40),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "Let try to have smart life",
              style: AppTextStyle.bodyTextStyleH3(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            _buildStartedButton(),
            const SizedBox(
              height: 64,
            ),
          ],
        ),
      );

  _buildStartedButton() => MushRoomButtonWidget(
        label: 'Get Started',
        onPressed: () {
          debugPrint("Get Started");
        },
      );
}
