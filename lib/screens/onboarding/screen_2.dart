import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:flutter/material.dart';
import '../../routes/routes.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          const Positioned(
            top: 16,
            left: 16,
            child: BackButton(), // Add the BackButton here
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset('assets/images/cart.png', height: 450),
                const SizedBox(height: 20),
                Text(
                  'AgriLink is where Your\n         Harvest Lives',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  '\n\nEnjoy a fast and smooth distribution of \n                     your harvest',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 50),
                PrimaryButtonDark(
                    text: 'Next',
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
