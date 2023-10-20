import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_event.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_state.dart';

class ItemBottomBarWidget extends StatelessWidget {
  final int index;
  final String icon;
  final String label;

  const ItemBottomBarWidget({
    required this.index,
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomBarBloc = injector<BottomBarBloc>(); // Get bloc from injector
    return StreamBuilder<BottomBarState>(
      stream: bottomBarBloc.stream, // Listen to bloc's state stream
      builder: (context, snapshot) {
        int currentIndex = 0; // Default value
        if (snapshot.hasData && snapshot.data is TabState) {
          currentIndex = (snapshot.data as TabState).currentIndex;
        }
        return GestureDetector(
          onTap: () {
            bottomBarBloc.add(TabSelected(index)); // Use bloc directly
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                height: 20,
                width: 20,
                icon,
                color: currentIndex == index ? Colors.black87 : Colors.black26,
              ),
              Text(label),
            ],
          ),
        );
      },
    );
  }
}
