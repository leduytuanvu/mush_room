import 'package:flutter/material.dart';
import 'package:mush_room/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/privacy_policy_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/register_page.dart';
import 'package:mush_room/features/auth/register/ui/pages/terms_of_service.dart';
import 'package:mush_room/features/bottom_bar/ui/pages/bottom_bar_page.dart';
import 'package:mush_room/features/device/add_device/ui/pages/add_device_page.dart';
import 'package:mush_room/features/device/home/ui/pages/home_page.dart';
import 'package:mush_room/features/device/set_up_wifi/ui/pages/set_up_wifi_page.dart';
import 'package:mush_room/features/profile/ui/pages/profile_page.dart';
import 'package:mush_room/features/splash/ui/pages/splash_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/bottom-bar':
        return MaterialPageRoute(builder: (_) => const BottomBarPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/add-device':
        return MaterialPageRoute(builder: (_) => const AddDevicePage());
      case '/scan-qr-code':
        return MaterialPageRoute(builder: (_) => const AddDevicePage());
      case '/register':
        return MaterialPageRoute(builder: (_) =>  RegisterPage());
      case '/terms-of-service':
        return MaterialPageRoute(builder: (_) => const TermsOfServicePage());
      case '/privacy-policy':
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
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

appNavigation(BuildContext context, Widget page, {bool isComeBack = true}) {
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
  if (isComeBack) {
    Navigator.of(context).push(pageRouterBuilder);
  } else {
    Navigator.of(context).pushReplacement(pageRouterBuilder);
  }
}
