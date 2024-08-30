import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'theme/theme.dart'; // Import your theme
import 'screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
    try {
    await dotenv.load(fileName: '.env');
    print("Environment variables loaded successfully.");
  } catch (e) {
    print("Error loading .env file: $e");
    return;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AgriLinkApp());
}

class AgriLinkApp extends StatelessWidget {
  const AgriLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'AgriLink',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
