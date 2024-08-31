import 'package:agrilink/screens/authentication/login_screen.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:flutter/material.dart';

class Intro2 extends StatelessWidget {
  const Intro2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          const Positioned(
            top: 40,
            left: 16,
            child: BackButtonWidget(), // Add the BackButton here
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 60),
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
                  const SizedBox(height: 30),
                  PrimaryButtonDark(
                    text: 'Next',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
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
}
