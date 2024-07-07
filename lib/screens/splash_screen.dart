import 'package:agrilink/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.intro1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color:
              theme.scaffoldBackgroundColor, // Use background color from theme
          image: const DecorationImage(
            image: AssetImage('assets/patterns/full.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Logo(), // Optional loading indicator
        ),
      ),
    );
  }
}
