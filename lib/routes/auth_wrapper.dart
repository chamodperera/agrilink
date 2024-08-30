import 'package:agrilink/screens/onboarding/screen_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart'; // Import your auth provider
import '../layouts/main_layout.dart'; // Import main layout
import '../screens/main/home.dart'; // Import main screens
import '../screens/main/services.dart';
import '../screens/main/profile.dart';
import '../screens/main/dashboard.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isSignedIn) {
      // If user is signed in, show the main layout
      print("Signed in");
      print(authProvider.user);
      return MainLayout(
        pages: [
          HomeScreen(),
          const ServicesScreen(),
          const DashboardScreen(),
          const ProfileScreen(),
        ],
      );
    } else {
      // If user is not signed in, show the login screen
      print("Not signed in");
      return const Intro1();
    }
  }
}
