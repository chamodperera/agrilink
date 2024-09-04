import 'package:agrilink/routes/auth_wrapper.dart';
import 'package:agrilink/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agrilink/app_localizations.dart';

class SplashScreen extends StatefulWidget {

  final Function(Locale) changeLanguage;

  SplashScreen({required this.changeLanguage});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      // Check if the widget is still mounted before navigating
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthWrapper(changeLanguage: widget.changeLanguage,)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
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
