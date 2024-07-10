import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:flutter/material.dart';
import '../../routes/routes.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset('assets/images/veg.png', height: 450),
            const SizedBox(height: 20),
            Text(
              'Find Your Perfect\n    Retailer here',
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              '\n\nHere You Can find a retailer or a \n     Distributor for your harvest',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 50),
            PrimaryButtonDark(
                text: 'Next',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.intro2);
                }),
          ],
        ),
      ),
    );
  }
}
