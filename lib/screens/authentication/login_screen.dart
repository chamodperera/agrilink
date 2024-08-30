import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/google.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrilink/widgets/form/input.dart';
import '../../providers/auth_provider.dart';
import '../../routes/routes.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    const Logo(),
                    const SizedBox(height: 50),
                    Text(
                      'Login To Your Account',
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 30),
                    const TextBox(text: 'Email'),
                    const SizedBox(height: 10),
                    const TextBox(
                      text: 'Password',
                      isPassword: true,
                    ),
                    Text(
                      '\nforgot password?',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Continue with',
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 15),
                    GoogleLogin(),
                    const SizedBox(height: 30),
                    PrimaryButtonDark(
                      text: 'Login',
                      onPressed: () async {
                      },
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(AppRoutes
                            .signup); // Use the appropriate route name for the sign-up page
                      },
                      child: Text(
                        "\ndon't have an account?",
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
            ),
          ],
        ),
      ),
    );
  }
}
