import 'package:agrilink/app_localizations.dart';
import 'package:agrilink/screens/onboarding/screen_2.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:flutter/material.dart'; // Adjust the import according to your project structure

class Intro1 extends StatelessWidget {
  final Function(Locale) changeLanguage;

  const Intro1({required this.changeLanguage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset('assets/images/veg.png', height: 450),
              const SizedBox(height: 20),
              Text(
                localizations.translate('find_perfect_retailer'),
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                localizations.translate('find_retailer_description'),
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 30),
              PrimaryButtonDark(
                text: localizations.translate('next'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Intro2(changeLanguage: changeLanguage,)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}