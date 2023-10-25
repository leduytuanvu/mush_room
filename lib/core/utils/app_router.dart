import 'package:flutter/material.dart';
import 'package:mush_room/core/services/navigation_service.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/verification_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/privacy_policy_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/register_page.dart';
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';
import 'package:mush_room/features/device/add_device/ui/pages/add_device_page.dart';
import 'package:mush_room/features/device/device_detail/ui/pages/device_detail_page.dart';
import 'package:mush_room/features/device/home/ui/pages/home_page.dart';
import 'package:mush_room/features/device/notification/ui/pages/notification_page.dart';
import 'package:mush_room/features/device/set_up_device/ui/pages/set_up_device_page.dart';
import 'package:mush_room/features/device/set_up_wifi/ui/pages/set_up_wifi_page.dart';
import 'package:mush_room/features/profile/ui/pages/change_infor_page.dart';
import 'package:mush_room/features/profile/ui/pages/frequently_question_page.dart';
import 'package:mush_room/features/profile/ui/pages/infor_profile_page.dart';
import 'package:mush_room/features/profile/ui/pages/information_about_mush_room_page.dart';
import 'package:mush_room/features/profile/ui/pages/profile_page.dart';
import 'package:mush_room/features/profile/ui/pages/set_up_device_manual_page.dart';
import 'package:mush_room/features/profile/ui/pages/support_page.dart';
import 'package:mush_room/features/profile/ui/pages/terms_of_user_page.dart';
import 'package:mush_room/features/profile/ui/pages/user_manual_page.dart';
import 'package:mush_room/features/profile/ui/pages/warrantly_policy_page.dart';
import 'package:mush_room/features/profile/ui/pages/warranty_information_page.dart';
import 'package:mush_room/features/splash/ui/pages/splash_page.dart';

class AppRouter {
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/bottom-bar':
        return MaterialPageRoute(builder: (_) => BottomBarPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/add-device':
        return MaterialPageRoute(builder: (_) => const AddDevicePage());
      case '/scan-qr-code':
        return MaterialPageRoute(builder: (_) => const AddDevicePage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/privacy-policy':
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case '/verification':
        String email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerificationPage(email: email));
      case '/notification':
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case '/device-detail':
        return MaterialPageRoute(builder: (_) => const DeviceDetailPage());
      case '/infor-profile':
        return MaterialPageRoute(builder: (_) => InforProfilePage());
      case '/warranty-information':
        return MaterialPageRoute(
            builder: (_) => const WarrantlyInformationPage());
      case '/user-manual':
        return MaterialPageRoute(builder: (_) => const UserManualPage());
      case '/warranty-policy':
        return MaterialPageRoute(builder: (_) => const WarrantlyPolicyPage());
      case '/term-of-user':
        return MaterialPageRoute(builder: (_) => const TermOfUserPage());
      case '/set-up-device':
        return MaterialPageRoute(builder: (_) => SetUpDevicePage());
      // case '/report-attempt':
      //   return MaterialPageRoute(builder: (_) => ReportAttemptPage());
      case '/support':
        return MaterialPageRoute(builder: (_) => const SupportPage());
      case '/frequently-question':
        return MaterialPageRoute(
            builder: (_) => const FrequentlyQuestionPage());
      case '/information-about-mush-room':
        return MaterialPageRoute(
            builder: (_) => const InformationAboutMushRoomPage());
      case '/set-up-device-manual':
        return MaterialPageRoute(builder: (_) => SetUpDeviceManualPage());
      case '/change-infor-profile':
        return MaterialPageRoute(
            builder: (_) => ChangeInforProfilePage(title: "", value: ""));
      case '/set-up-wifi':
        String qrCodeData = settings.arguments
            as String; // assuming you pass qrCodeData as a String
        return MaterialPageRoute(
            builder: (_) => SetUpWifiPage(qrCodeData: qrCodeData));
      // Other cases for other routes
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

appNavigation(
  Widget page, {
  bool isComeBack = true,
  bool isRemoveAll = false,
}) {
  final pageRouterBuilder = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0); // Start from the left
      const end = Offset(0.0, 0.0); // Move to the right
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
  if (isComeBack && !isRemoveAll) {
    NavigationService().navigationKey.currentState?.push(pageRouterBuilder);
  } else if (isRemoveAll) {
    NavigationService().navigationKey.currentState?.pushAndRemoveUntil(
          pageRouterBuilder,
          (route) => false, // Remove all previous routes
        );
  } else {
    NavigationService()
        .navigationKey
        .currentState
        ?.pushReplacement(pageRouterBuilder);
  }
}
