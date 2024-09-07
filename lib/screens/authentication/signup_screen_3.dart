import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/routes/auth_wrapper.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/form/input.dart';
import 'package:agrilink/widgets/form/validators.dart';
import 'package:provider/provider.dart';
import '../../widgets/form/image_input.dart'; // Import your ImageInputWidget
import '../../widgets/form/multi_select.dart'; // Import your MultiSelectWidget
import '../../providers/auth_provider.dart'; // Import AuthProvider
import 'package:agrilink/app_localizations.dart';


class SignUp3 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String district;
  final File? selectedImage; // Image from previous screen
  final Uint8List? webImage; // Web image from previous screen
final Function(Locale) changeLanguage;

  const SignUp3({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.district,
    this.selectedImage,
    this.webImage,
    required this.changeLanguage,
  });

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  // Available roles for selection
  final List<String> availableItems = ['Farmer', 'Distributor', 'Retailer'];
  List<String> selectedItems = []; // Selected roles
  bool _isLoading = false;

  // Image variables
  File? _selectedImage;
  Uint8List? _webImage;

  // Password controllers and error messages
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  String? _passwordErrorMessage;
  String? _rePasswordErrorMessage;
  String? _rolesErrorMessage;

  // Form key
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.selectedImage;
    _webImage = widget.webImage;
  }

  // Method to handle role selection changes
  void _onSelectionChanged(List<String> selectedList) {
    setState(() {
      selectedItems = selectedList;
      _rolesErrorMessage = null; // Clear error message when selection changes
    });
  }


  // Validate all fields and navigate or show error messages
  void _validateAndSubmit(BuildContext context) async {
    setState(() {
      _passwordErrorMessage = null;
      _rePasswordErrorMessage = null;
      _rolesErrorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      // Check if passwords match
      if (passwordController.text != rePasswordController.text) {
        setState(() {
          _rePasswordErrorMessage = "Passwords do not match";
        });
        return;
      }

      // Check if at least one role is selected
      if (selectedItems.isEmpty) {
        setState(() {
          _rolesErrorMessage = "Please select at least one role";
        });
        return;
      }

      // If all validations pass, complete sign-up
      await _completeSignUp(context);
    }
  }

  // Complete the sign-up process
  Future<void> _completeSignUp(BuildContext context) async {
    // Get AuthProvider instance
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _isLoading = true;

    try {
      File? imageFile = _selectedImage;
      if (kIsWeb && _webImage != null) {
        imageFile = File(_webImage!.toString()); // Handle web image
      }

      await authProvider.createUserAccount(
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
        phone: widget.mobileNumber,
        roles: selectedItems,
        password: passwordController.text,
        district: widget.district,
        imageFile: imageFile, // Pass image file if available
      );

      // Navigate to the main screen after successful sign-up
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AuthWrapper(changeLanguage: widget.changeLanguage,),
        ),
      );
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/patterns/full.png"),
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
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Select your role/roles",
                        style: theme.textTheme.displaySmall
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      // Image input widget
                      MultiSelectWidget(
                        items: availableItems,
                        onSelectionChanged: _onSelectionChanged,
                        errorMessage: _rolesErrorMessage,
                      ),
                      const SizedBox(height: 20),
                      TextBox(
                        text: 'Password',
                        isPassword: true,
                        controller: passwordController,
                        validator: validatePassword,
                        errorMessage: _passwordErrorMessage,
                      ),
                      const SizedBox(height: 10),
                      TextBox(
                        text: 'Re-enter Password',
                        isPassword: true,
                        controller: rePasswordController,
                        errorMessage: _rePasswordErrorMessage,
                      ),
                      const SizedBox(height: 30),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : PrimaryButtonDark(
                              text: 'Sign Up',
                              onPressed: () => _validateAndSubmit(context),
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
