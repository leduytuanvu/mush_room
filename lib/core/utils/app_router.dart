import 'package:flutter/material.dart';
import 'package:mush_room/features/splash/ui/pages/splash_page.dart';
// Import other pages

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/feature1':
        return MaterialPageRoute(builder: (_) => const SplashPage());
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
