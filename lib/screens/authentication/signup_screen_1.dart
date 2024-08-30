import 'package:agrilink/screens/authentication/login_screen.dart';
import 'package:agrilink/screens/authentication/signup_screen_2.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/form/input.dart';
import '../../widgets/form/validators.dart';

class SignUp1 extends StatelessWidget {
  const SignUp1({super.key});

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
              top: 40,
              left: 16,
              child: BackButtonWidget(), // Add the BackButtonWidget here
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  const Logo(),
                  const SizedBox(height: 50),
                  Text(
                    'Sign Up For Free',
                    style: theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 30),
                  const TextBox(
                      text: 'First Name',
                      validator: validateName), // Update TextBox with validator
                  const SizedBox(height: 10),
                  const TextBox(
                      text: 'Last Name',
                      validator: validateName), // Update TextBox with validator
                  const SizedBox(height: 10),
                  const TextBox(
                      text: 'Email',
                      validator:
                          validateEmail), // Update TextBox with validator
                  const SizedBox(height: 10),
                  const TextBox(
                      text: 'Mobile Number',
                      validator:
                          validateMobile), // Update TextBox with validator
                  const SizedBox(height: 30),
                  PrimaryButtonDark(
                    text: 'Next',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SignUp2()));
                      ;
                    },
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Login()));
                      // Use the appropriate route name for the sign-up page
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
