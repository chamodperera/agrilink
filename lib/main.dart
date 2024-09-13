import 'package:agrilink/app_localizations.dart';
import 'package:agrilink/screens/language_selection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'theme/theme.dart'; // Import your theme
import 'screens/splash_screen.dart';
 // Import your GoogleMapsScreen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(AgriLinkApp());
}

class AgriLinkApp extends StatefulWidget{
  @override
  _AgriLinkAppState createState() => _AgriLinkAppState();
}

class _AgriLinkAppState extends State<AgriLinkApp> {
  Locale _locale = const Locale('en');

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        locale: _locale,
        supportedLocales: const [
          Locale('en'),
          Locale('si'),
          Locale('ta'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        title: 'AgriLink',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(changeLanguage: changeLanguage),
      ),
    );
  }
}
