import 'package:flutter/material.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/mqtt/mqtt_publish.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/core/services/shared_preference_service.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/features/auth/login/ui/pages/login_page.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_bloc.dart';
import 'package:mush_room/features/bottom_bar/bloc/bottom_bar_event.dart';
import 'package:mush_room/features/profile/bloc/profile/profile_bloc.dart';
import 'package:mush_room/features/profile/bloc/profile/profile_event.dart';
import 'package:mush_room/features/profile/ui/pages/infor_profile_page.dart';
import 'package:mush_room/features/profile/ui/pages/information_about_mush_room_page.dart';
import 'package:mush_room/features/profile/ui/pages/terms_of_user_page.dart';
import 'package:mush_room/features/profile/ui/pages/user_manual_page.dart';
import 'package:mush_room/features/profile/ui/pages/warrantly_policy_page.dart';
import 'package:mush_room/features/profile/ui/pages/warranty_information_page.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/dialog/mush_room_dialog_confirm_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final profileBloc = injector<ProfileBloc>();
  final shared = injector<SharedPreferenceService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              appNavigation(InforProfilePage());
            },
            child: Container(
              decoration: const BoxDecoration(
                color: AppConstants.appBarColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 4.0,
                    color: Colors.black38,
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                bottom: 24,
                right: 24,
                left: 24,
                top: 60,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink,
                    ),
                    height: 80,
                    width: 80,
                    child:
                        Assets.icons.iconProfile.image(width: 50, height: 50),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        shared.getUsername(),
                        maxLines: 2, // Display a single line of text
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.titleTextStyleH3().copyWith(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        shared.getEmail(),
                        maxLines: 2, // Display a single line of text
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.smallTextStyle()
                            .copyWith(color: Colors.white70),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // const SizedBox(height: 10),
          // const Divider(color: Colors.grey),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 12),
                _buildItem(content: "Warranty information", context, onTap: () {
                  appNavigation(const WarrantlyInformationPage());
                }),
                _buildItem(content: "User manual", context, onTap: () {
                  appNavigation(const UserManualPage());
                }),
                _buildItem(content: "Warranty Policy", context, onTap: () {
                  appNavigation(const WarrantlyPolicyPage());
                }),
                _buildItem(content: "Terms Of Use", context, onTap: () {
                  appNavigation(const TermOfUserPage());
                }),
                // _buildItem(content: "Report Attempt", context, onTap: () {
                //   appNavigation(ReportAttemptPage());
                // }),
                _buildItem(content: "Support", context, onTap: () {
                  // appNavigation(const SupportPage());
                  MqttPublishFunc.instance.sendTest();
                }),
                _buildItem(content: "Information About MushRoom", context,
                    onTap: () {
                  appNavigation(const InformationAboutMushRoomPage());
                }),
                _buildItem(content: "Delete the account", context, onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: NavigationService().currentContext(),
                    builder: (context) => MushRoomShowDialogConfirmWidget(
                      // isShowIcon: true,
                      colorButton: Colors.red,
                      icon: const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 80,
                      ),
                      title: "Do you want to delete your account?",
                      titleButton1: "Cancel",
                      titleButton2: "Ok",
                      functionButton1: () {
                        NavigationService().goBack();
                      },
                      functionButton2: () {
                        // final shared = injector<SharedPreferenceService>();
                        // shared.clearUser();
                        // appNavigation(LoginPage(), isRemoveAll: true);
                        profileBloc.add(ProfileDeleteAccountEvent());
                      },
                    ),
                  );
                }),
                _buildItem(content: "Logout", context, isEnd: true, onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: NavigationService().currentContext(),
                    builder: (context) => MushRoomShowDialogConfirmWidget(
                      title: "Do you want to logout?",
                      titleButton1: "Cancel",
                      titleButton2: "Ok",
                      functionButton1: () {
                        NavigationService().goBack();
                      },
                      functionButton2: () {
                        final shared = injector<SharedPreferenceService>();
                        shared.clearUser();
                        final bottomBarBloc = injector<BottomBarBloc>();
                        bottomBarBloc.add(ResetBottomBarEvent());
                        appNavigation(LoginPage(), isRemoveAll: true);
                      },
                    ),
                  );
                }),
                const SizedBox(height: 100),
              ],
            ),
          ),
          // const Divider(color: Colors.grey),
        ],
      ),
    );
  }

  _buildItem(BuildContext context,
          {required String content,
          void Function()? onTap,
          bool isEnd = false}) =>
      GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      content,
                      style: (content == "Delete the account" ||
                              content == "Logout")
                          ? Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.red)
                          : Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  content == "Delete the account"
                      ? const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 18,
                        )
                      : (content == "Logout"
                          ? const Icon(
                              Icons.logout,
                              color: Colors.red,
                              size: 18,
                            )
                          : const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ))
                ],
              ),
              const SizedBox(height: 12),
              !isEnd ? const Divider() : const SizedBox.shrink()
            ],
          ),
        ),
      );

  _buildLogOutButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: MushRoomButtonWidget(
          label: "Logout",
          onPressed: () {
            // final shared = injector<SharedPreferenceService>();

            // profileBloc.add(ShowLogoutProfileEvent());
            // bottomBarBloc.add(ResetBottomBarEvent());
            // shared.clearUser();
            // appNavigation(LoginPage(), isRemoveAll: true);
          },
        ),
      );
}
