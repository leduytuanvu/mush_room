import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_event.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_state.dart';
import 'package:mush_room/features/bottom_bar/ui/widgets/item_bottom_bar_widget.dart';
import 'package:mush_room/features/device/home/ui/pages/home_page.dart';
import 'package:mush_room/features/profile/bloc/profile_bloc.dart';
import 'package:mush_room/features/profile/bloc/profile_event.dart';
import 'package:mush_room/features/profile/bloc/profile_state.dart';
import 'package:mush_room/features/profile/ui/pages/profile_page.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/dialog/mush_room_dialog_widget.dart';

class BottomBarPage extends StatelessWidget {
  BottomBarPage({super.key});
  final bottomBarBloc = injector<BottomBarBloc>();
  final profileBloc = injector<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: AppConstants.appBarColor,
          body: Column(
            children: [
              _buildMain(),
              _buildBottomBar(),
            ],
          ),
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          bloc: profileBloc, // Using bottomBarBloc directly
          builder: (context, state) {
            if (state is ShowLogoutProfileState) {
              return MushRoomDialogWidget(title: "Do you want to logout?",
              titleButton1: "Cancle",
                titleButton2: "Ok",
                function1: (){
                  profileBloc.add(ResetProfileEvent());
                },
                function2: (){
                  final shared = injector<SharedPreferenceService>();
                  final profileBloc = injector<ProfileBloc>();
                  profileBloc.add(ShowLogoutProfileEvent());
                  bottomBarBloc.add(ResetBottomBarEvent());
                  shared.clearUser();
                  appNavigation(context, LoginPage(), isRemoveAll: true);
                },
                functionClose: (){
                  profileBloc.add(ResetProfileEvent());
                },
              );
            }
            // Handle other states or return a fallback widget
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  // Main widget
  _buildMain() {
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
        decoration:  BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0.0, 3.0),
              blurRadius: 5.0,
              spreadRadius: -1.0,
              color: Colors.grey,
            ),
            BoxShadow(
              offset: Offset(0.0, 6.0),
              blurRadius: 10.0,
              color: Colors.grey,
            ),
          ],
        ),
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
