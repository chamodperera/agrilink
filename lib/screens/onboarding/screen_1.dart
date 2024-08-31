import 'package:agrilink/screens/onboarding/screen_2.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:flutter/material.dart';

class Intro1 extends StatelessWidget {
  const Intro1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                'Find Your Perfect\n    Retailer here',
                style: theme.textTheme.bodyMedium,
              ),
              Text(
                '\n\nHere You Can find a retailer or a \n     Distributor for your harvest',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 30),
              PrimaryButtonDark(
                text: 'Next',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Intro2()),
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
