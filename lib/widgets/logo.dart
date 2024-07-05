import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo.png',
            height: 100), // Adjust the height as needed
        const SizedBox(height: 10),
        Text(
          'AgriLink',
          style: theme.textTheme.displayLarge,
        ),
        const SizedBox(height: 10),
        Text(
          'From Farm to Fork',
          style: theme.textTheme.displaySmall,
        ),
      ],
    );
  }
}
