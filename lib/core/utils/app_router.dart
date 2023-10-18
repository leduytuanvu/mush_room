import 'package:flutter/material.dart';
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
      case '/set-up-wifi':
        String qrCodeData = settings.arguments as String;  // assuming you pass qrCodeData as a String
        return MaterialPageRoute(builder: (_) => SetUpWifiPage(qrCodeData: qrCodeData));
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
