import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

void main() {
  runApp(const AgriLinkApp());
}

class AgriLinkApp extends StatelessWidget {
  const AgriLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriLink',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false, // remove debug banner
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.getRoutes(),
    );
  }
}
