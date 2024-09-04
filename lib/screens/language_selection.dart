import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:agrilink/app_localizations.dart';
import 'package:agrilink/screens/onboarding/screen_1.dart'; // Adjust the import according to your project structure

class LanguageSelectionScreen extends StatelessWidget {
  final Function(Locale) changeLanguage;

  LanguageSelectionScreen({required this.changeLanguage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    localizations.translate('select_language'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildLanguageButton(
                    context,
                    label: "English",
                    onPressed: () {
                      changeLanguage(const Locale('en'));
                      _navigateToIntroScreen(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildLanguageButton(
                    context,
                    label: "සිංහල",
                    onPressed: () {
                      changeLanguage(const Locale('si'));
                      _navigateToIntroScreen(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context, {required String label, required VoidCallback onPressed}) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: theme.colorScheme.primary, backgroundColor: theme.colorScheme.onBackground,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(FluentIcons.globe_12_filled, color: theme.colorScheme.primary),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _navigateToIntroScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Intro1(changeLanguage: changeLanguage),
      ),
    );
  }
}
