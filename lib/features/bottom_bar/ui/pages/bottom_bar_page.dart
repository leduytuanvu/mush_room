import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_state.dart';
import 'package:mush_room/features/bottom_bar/ui/widgets/item_bottom_bar_widget.dart';
import 'package:mush_room/features/device/home/ui/pages/home_page.dart';
import 'package:mush_room/features/profile/ui/pages/profile_page.dart';
import 'package:mush_room/gen/assets.gen.dart';

class BottomBarPage extends StatelessWidget {
  const BottomBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildMain(),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  // Main widget
  _buildMain() {
    final bottomBarBloc = injector<BottomBarBloc>();
    var listScreen = [const HomePage(), ProfilePage()];
    return Expanded(
      child: NotificationListener<UserScrollNotification>(
        onNotification: (scrollController) {
          if (scrollController.metrics.pixels ==
              scrollController.metrics.maxScrollExtent) {
          } else {
            // log('${scrollController.metrics.pixels}');
            // log('${scrollController.metrics.maxScrollExtent}');
          }
          if (scrollController.direction == ScrollDirection.reverse) {
            // controller.isVisible.value = false;
          }
          if (scrollController.direction == ScrollDirection.forward) {
            // controller.isVisible.value = true;
          }
          return true;
        },
        child: BlocBuilder<BottomBarBloc, BottomBarState>(
          bloc: bottomBarBloc, // Using bottomBarBloc directly
          builder: (context, state) {
            if (state is TabState) {
              return IndexedStack(
                index: state.currentIndex,
                children: listScreen,
              );
            }
            // Handle other states or return a fallback widget
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  // Bottom bar widget
  _buildBottomBar() => Container(
        decoration: const BoxDecoration(color: Colors.white),
        height: 64.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildItemHomeBottomBar(),
            _buildItemProfileBottomBar(),
          ],
        ),
      );

  // Item bottom bar home widget
  _buildItemHomeBottomBar() => Expanded(
        child: ItemBottomBarWidget(
          index: 0,
          icon: Assets.svgs.iconHome,
          label: 'Home',
        ),
      );

  // Item bottom bar profile widget
  _buildItemProfileBottomBar() => Expanded(
        child: ItemBottomBarWidget(
          index: 1,
          icon: Assets.svgs.iconProfile,
          label: 'Profile',
        ),
      );
}
