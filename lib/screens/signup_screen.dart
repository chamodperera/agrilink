import 'package:agrilink/widgets/backButton.dart';
import 'package:agrilink/widgets/greenButton.dart';
import 'package:agrilink/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/textBox.dart';
import '../routes/routes.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/patterns/full.png"), // Specify the path to your image asset
            fit: BoxFit
                .cover, // This will cover the entire widget area without changing the aspect ratio of the image
          ),
        ),
        child: Stack(
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
                  const Logo(),
                  const SizedBox(height: 55),
                  Text(
                    'Sign Up For Free',
                    style: theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 45),
                  const TextBox(text: 'First Name'),
                  const SizedBox(height: 10),
                  const TextBox(text: 'Last Name'),
                  const SizedBox(height: 10),
                  const TextBox(text: 'Email'),
                  const SizedBox(height: 10),
                  const TextBox(text: 'Mobile Number'),
                  const SizedBox(height: 30),
                  GreenButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.intro1);
                    },
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(AppRoutes
                          .login); // Use the appropriate route name for the sign-up page
                    },
                    child: Text(
                      "\nalready have an account?",
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
