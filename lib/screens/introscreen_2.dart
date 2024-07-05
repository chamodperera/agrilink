import 'package:agrilink/widgets/backButton.dart';
import 'package:agrilink/widgets/greenButton.dart';
import 'package:flutter/material.dart';
import '../routes/routes.dart';

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
            child: BackButtonWidget(), // Add the BackButtonWidget here
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset('assets/images/cart.png', height: 450),
                const SizedBox(height: 20),
                Text(
                  'AgriLink is where Your\n         Harvest Lives',
                  style: theme.textTheme.displayMedium,
                ),
                Text(
                  '\n\nEnjoy a fast and smooth distribution of \n                     your harvest',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 50),
                GreenButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.login);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
