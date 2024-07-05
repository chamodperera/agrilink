import 'package:agrilink/screens/login_screen.dart';
import 'package:agrilink/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import '../screens/splashscreen.dart';
// import '../screens/home_screen.dart';
// import '../screens/details_screen.dart';
// import '../screens/settings_screen.dart';
import '../screens/introscreen_1.dart';
import '../screens/introscreen_2.dart';

class AppRoutes {
  static const String splash = '/';
  // static const String home = '/home';
  // static const String details = '/details';
  // static const String settings = '/settings';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String intro1 = '/intro1';
  static const String intro2 = '/intro2';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      // home: (context) => HomeScreen(),
      // details: (context) => DetailsScreen(),
      // settings: (context) => SettingsScreen(),
      intro1: (context) => const Intro1(),
      intro2: (context) => const Intro2(),
      login: (context) => const Login(),
      signup: (context) => const SignUp(),
    };
  }
}
