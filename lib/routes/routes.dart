import 'package:agrilink/layouts/main_layout.dart';
import 'package:agrilink/screens/authentication/login_screen.dart';
import 'package:agrilink/screens/authentication/signup_screen.dart';
import 'package:agrilink/screens/main/dashboard.dart';
import 'package:agrilink/screens/main/home.dart';
import 'package:agrilink/screens/main/profile.dart';
import 'package:agrilink/screens/main/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding/screen_1.dart';
import '../screens/onboarding/screen_2.dart';
import '../providers/auth_provider.dart'; // Import the AuthProvider

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String intro1 = '/intro1';
  static const String intro2 = '/intro2';
  static const String main = '/main';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.user != null) {
          return MainLayout(
            pages: [
              HomeScreen(),
              const ServicesScreen(),
              const DashboardScreen(),
              const ProfileScreen(),
            ],
          );
        } else {
          return const SplashScreen();
        }
      },
      intro1: (context) => const Intro1(),
      intro2: (context) => const Intro2(),
      login: (context) => const Login(),
      signup: (context) => const SignUp(),
    };
  }
}
