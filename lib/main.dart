import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AgriLinkApp());
}

class AgriLinkApp extends StatelessWidget {
  const AgriLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: MaterialApp(
          title: 'AgriLink',
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false, // remove debug banner
          // initialRoute: AppRoutes.splash,
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.getRoutes(),
        ));
  }
}
