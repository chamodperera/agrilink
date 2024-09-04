import 'package:agrilink/screens/authentication/login_screen.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/app_localizations.dart';

class Intro2 extends StatelessWidget {
  final Function(Locale) changeLanguage;

  Intro2({required this.changeLanguage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body:Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset('assets/images/cart.png', height: 450),
                  const SizedBox(height: 20),
                  Text(
                    localizations.translate('harvest_lives'),
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    localizations.translate('smooth_distribution'),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 30),
                  PrimaryButtonDark(
                    text: localizations.translate('next'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Login(changeLanguage: changeLanguage,),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
            const Positioned(
            top: 40,
            left: 16,
            child: BackButtonWidget(), // Add the BackButton here
          ),
        ],
      ),
    );
  }
}
