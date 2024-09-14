import 'package:agrilink/routes/auth_wrapper.dart';
import 'package:agrilink/screens/authentication/signup_screen_1.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrilink/widgets/form/input.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/form/validators.dart'; 
import 'package:agrilink/app_localizations.dart';
import 'package:toastification/toastification.dart';
class Login extends StatefulWidget {
  final Function(Locale) changeLanguage;

  const Login({required this.changeLanguage});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  String? _emailError; // To store authentication error message
  String? _passwordError; // To store authentication error message
  bool _isLoading = false; // To track loading state
  bool _isResetLoading = false; // To track loading state

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

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
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: _formKey, // Use form key
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const Logo(),
                      const SizedBox(height: 50),
                      Text(
                        localizations.translate('login'),
                        style: theme.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 30),
                      // Use TextBox with email controller
                      TextBox(
                          text: localizations.translate('email'),
                          controller: emailController,
                          validator: validateEmail,
                          errorMessage: _emailError),
                      const SizedBox(height: 10),
                      // Use TextBox with password controller and dynamic error message
                      TextBox(
                        text: localizations.translate('password'),
                        isPassword: true,
                        controller: passwordController,
                        errorMessage: _passwordError, // Set the error message
                      ),
                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: _isResetLoading
                            ? null
                            : () async {
                                final email = emailController.text.trim();
                                if (email.isNotEmpty) {
                                  setState(() {
                                    _isResetLoading = true;
                                  });
                                  try {
                                    await authProvider
                                        .sendPasswordResetEmail(email);
                                    toastification.show(
                                        context: context,
                                        type: ToastificationType.success,
                                        style: ToastificationStyle.flatColored,
                                        title: Text("Success!"),
                                        description: Text(
                                            "Password reset email sent successfully!"),
                                        alignment: Alignment.topCenter,
                                        autoCloseDuration:
                                            const Duration(seconds: 4),
                                        primaryColor: theme.colorScheme.primary,
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        foregroundColor: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        showProgressBar: false);
                                  } catch (e) {
                                    toastification.show(
                                        context: context,
                                        type: ToastificationType.error,
                                        style: ToastificationStyle.flatColored,
                                        title: Text("Error!"),
                                        description: Text("Email not found!"),
                                        alignment: Alignment.topCenter,
                                        autoCloseDuration:
                                            const Duration(seconds: 4),
                                        primaryColor: theme.colorScheme.error,
                                        backgroundColor:
                                            theme.colorScheme.error,
                                        foregroundColor: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        showProgressBar: false);
                                  } finally {
                                    setState(() {
                                      _isResetLoading = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    _emailError = localizations
                                        .translate('email_required');
                                  });
                                }
                              },
                        child: Text(
                          localizations.translate('forgot_password'),
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Text(
                      //   'Continue with',
                      //   style: theme.textTheme.displaySmall,
                      // ),
                      // const SizedBox(height: 15),
                      // GoogleLogin(),
                      // const SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator() // Show loading indicator if loading
                          : PrimaryButtonDark(
                              text: localizations.translate('login_button'),
                              onPressed: () async {
                                // Validate form inputs
                                if (_formKey.currentState!.validate()) {
                                  final email = emailController.text.trim();
                                  final password =
                                      passwordController.text.trim();
                                  try {
                                    // Start loading
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    // Attempt to sign in with email and password
                                    await authProvider.signInWithEmail(
                                        email, password);

                                    // Navigate only if login is successful
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => AuthWrapper(
                                          changeLanguage: widget.changeLanguage,
                                        ), // Navigate to home screen
                                      ),
                                    );
                                  } catch (e) {
                                    // Set the authentication error message
                                    setState(() {
                                      _emailError = localizations
                                          .translate('email_password_error');
                                      _passwordError = localizations
                                          .translate('email_password_error');
                                    });
                                  } finally {
                                    // Stop loading
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                            ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUp1(
                                    changeLanguage: widget.changeLanguage,
                                  )));
                        },
                        child: Text(
                          localizations.translate('dont_have_account'),
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
            const Positioned(
              top: 40,
              left: 16,
              child: BackButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
