import 'package:agrilink/screens/authentication/login_screen.dart';
import 'package:agrilink/screens/authentication/signup_screen_2.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/form/input.dart';
import '../../widgets/form/validators.dart';
import 'package:agrilink/app_localizations.dart';


class SignUp1 extends StatelessWidget {

  final Function(Locale) changeLanguage;

  SignUp1({required this.changeLanguage});

  // TextEditingControllers to capture input
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  // GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  // Function to validate form and navigate to next screen
  void _validateAndNavigate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // If all fields are valid, navigate to SignUp2
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignUp2(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            mobileNumber: mobileController.text,
            changeLanguage: changeLanguage,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

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
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: _formKey, // Assign the key to the Form
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      const Logo(),
                      const SizedBox(height: 40),
                      Text(
                        'Sign Up For Free',
                        style: theme.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 30),
                      // Use TextBox with controller
                      TextBox(
                        text: localizations.translate('first_name'),
                        controller: firstNameController,
                        validator: validateName,
                      ),
                      const SizedBox(height: 10),
                      TextBox(
                        text: localizations.translate('last_name'),
                        controller: lastNameController,
                        validator: validateName,
                      ),
                      const SizedBox(height: 10),
                      TextBox(
                        text: localizations.translate('email'),
                        controller: emailController,
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 10),
                      TextBox(
                        text: localizations.translate('mobile'),
                        controller: mobileController,
                        validator: validateMobile,
                      ),
                      const SizedBox(height: 20),
                      PrimaryButtonDark(
                        text: localizations.translate('next'),
                        onPressed: () => _validateAndNavigate(
                            context), // Call the validateAndNavigate function
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Login(changeLanguage: changeLanguage,),
                          ));
                        },
                        child: Text(
                          localizations.translate('already_have_account'),
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
              child: BackButtonWidget(), // Add the BackButtonWidget here
            ),
          ],
        ),
      ),
    );
  }
}
