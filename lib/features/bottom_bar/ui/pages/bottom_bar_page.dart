import 'dart:developer';

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
    // var theme = Theme.of(context);
    // final textTheme = theme.textTheme;
    final bottomBarBloc = injector<BottomBarBloc>();
    var listScreen = [
      const HomePage(),
      ProfilePage(),
    ];
    // return BlocProvider<BottomBarBloc>(
    //   create: (context) => bottomBarBloc,
    //   child: Scaffold(
    //     resizeToAvoidBottomInset: false,
    //     backgroundColor: Colors.white,
    //     body: SafeArea(
    //       child: Stack(
    //         children: [
    //           NotificationListener<UserScrollNotification>(
    //             onNotification: (scrollController) {
    //               if (scrollController.metrics.pixels ==
    //                   scrollController.metrics.maxScrollExtent) {
    //               } else {
    //                 log('${scrollController.metrics.pixels}');
    //                 log('${scrollController.metrics.maxScrollExtent}');
    //               }
    //               if (scrollController.direction == ScrollDirection.reverse) {
    //                 // controller.isVisible.value = false;
    //               }
    //               if (scrollController.direction == ScrollDirection.forward) {
    //                 // controller.isVisible.value = true;
    //               }
    //               return true;
    //             },
    //             child: BlocBuilder<BottomBarBloc, BottomBarState>(
    //               bloc: bottomBarBloc,
    //               builder: (context, state) {
    //                 if (state is TabState) {
    //                   return IndexedStack(
    //                     index: state.currentIndex,
    //                     children: listScreen,
    //                   );
    //                 }
    //                 // Handle other states or return a fallback widget
    //                 return const SizedBox.shrink();  // Replace with your fallback widget
    //               },
    //             ),
    //           ),
    //           Positioned(
    //             bottom: 0.0,
    //             left: 0.0,
    //             right: 0.0,
    //             child: Stack(
    //               children: [
    //                 Container(
    //                     // decoration: BoxDecoration(color: theme.colorScheme.background),
    //                     decoration: BoxDecoration(color: Colors.white),
    //                     height: 60.0,
    //                     child:
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Expanded(
    //                           child: ItemBottomBarWidget(
    //                             index: 0,
    //                             icon: AppSvg.home,
    //                             label: 'Home',
    //                           ),
    //                         ),
    //                         Expanded(
    //                           child: ItemBottomBarWidget(
    //                             index: 1,
    //                             icon: AppSvg.profile,
    //                             label: 'Profile',
    //                           ),
    //                         ),
    //                       ],
    //                     )
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<UserScrollNotification>(
                onNotification: (scrollController) {
                  if (scrollController.metrics.pixels ==
                      scrollController.metrics.maxScrollExtent) {
                  } else {
                    log('${scrollController.metrics.pixels}');
                    log('${scrollController.metrics.maxScrollExtent}');
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
                    return const SizedBox
                        .shrink(); // Replace with your fallback widget
                  },
                ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(color: theme.colorScheme.background),
              decoration: const BoxDecoration(color: Colors.white),
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ItemBottomBarWidget(
                      index: 0,
                      icon: Assets.svgs.iconHome,
                      label: 'Home',
                    ),
                  ),
                  Expanded(
                    child: ItemBottomBarWidget(
                      index: 1,
                      icon: Assets.svgs.iconProfile,
                      label: 'Profile',
                    ),
                  ),
                ],
              ),
            )
            // Positioned(
            //   bottom: 0.0,
            //   left: 0.0,
            //   right: 0.0,
            //   child: Stack(
            //     children: [
            //       Container(
            //         // decoration: BoxDecoration(color: theme.colorScheme.background),
            //         decoration: const BoxDecoration(color: Colors.white),
            //         height: 60.0,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Expanded(
            //               child: ItemBottomBarWidget(
            //                 index: 0,
            //                 icon: Assets.svgs.iconHome,
            //                 label: 'Home',
            //               ),
            //             ),
            //             Expanded(
            //               child: ItemBottomBarWidget(
            //                 index: 1,
            //                 icon: Assets.svgs.iconProfile,
            //                 label: 'Profile',
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
