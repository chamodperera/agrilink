import 'package:flutter/material.dart';
import '../screens/splashscreen.dart';
// import '../screens/home_screen.dart';
// import '../screens/details_screen.dart';
// import '../screens/settings_screen.dart';
// import '../screens/login_screen.dart';

class AppRoutes {
  static const String splash = '/';
  // static const String home = '/home';
  // static const String details = '/details';
  // static const String settings = '/settings';
  // static const String login = '/login';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      // home: (context) => HomeScreen(),
      // details: (context) => DetailsScreen(),
      // settings: (context) => SettingsScreen(),
      // login: (context) => LoginScreen(),
    };
  }
}
