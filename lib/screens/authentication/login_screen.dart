import 'package:agrilink/routes/auth_wrapper.dart';
import 'package:agrilink/screens/authentication/signup_screen_1.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/google.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/form/input.dart';
import 'package:provider/provider.dart';
import '../../widgets/form/validators.dart'; // Import validators
import '../../providers/auth_provider.dart'; // Import AuthProvider

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  String? _emailError; // To store authentication error message
  String? _passwordError; // To store authentication error message

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/patterns/full.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 40,
              left: 16,
              child: BackButtonWidget(),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: _formKey, // Use form key
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
                      // Use TextBox with email controller
                      TextBox(
                          text: 'Email',
                          controller: emailController,
                          validator: validateEmail,
                          errorMessage: _emailError),
                      const SizedBox(height: 10),
                      // Use TextBox with password controller and dynamic error message
                      TextBox(
                        text: 'Password',
                        isPassword: true,
                        controller: passwordController,
                        errorMessage: _passwordError, // Set the error message
                      ),
                      const SizedBox(height: 10),
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
                      const GoogleLogin(),
                      const SizedBox(height: 30),
                      PrimaryButtonDark(
                        text: 'Login',
                        onPressed: () async {
                          // Validate form inputs
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            try {
                              // Attempt to sign in with email and password
                              await authProvider.signInWithEmail(
                                  email, password);

                              // Navigate only if login is successful
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthWrapper(), // Navigate to home screen
                                ),
                              );
                            } catch (e) {
                              // Set the authentication error message
                              setState(() {
                                _emailError = 'Email or password is incorrect';
                                _passwordError =
                                    'Email or password is incorrect';
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUp1()));
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
            ),
          ],
        ),
      ),
    );
  }
}
