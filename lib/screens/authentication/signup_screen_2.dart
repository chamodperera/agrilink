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

class SignUp2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;

  const SignUp2({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
  });

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  // Variables for image and role selection
  final List<String> availableItems = ['Farmer', 'Distributor', 'Retailer'];
  List<String> selectedItems = []; // Store selected items

  File? _selectedImage; // File for mobile
  Uint8List? _webImage; // Uint8List for web

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  String? _passwordErrorMessage; // Error message for password validation
  String? _rePasswordErrorMessage; // Error message for re-entered password
  String? _rolesErrorMessage; // Error message for roles validation

  final _formKey = GlobalKey<FormState>();

  // Method to handle role selection changes
  void _onSelectionChanged(List<String> selectedList) {
    setState(() {
      selectedItems = selectedList; // Update selected items
      _rolesErrorMessage = null; // Clear error message when selection changes
    });
  }

  // Method to handle image selection for mobile
  void _onImageSelected(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  // Method to handle image selection for web
  void _onWebImageSelected(Uint8List? imageBytes) {
    setState(() {
      _webImage = imageBytes;
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

  Future<void> _completeSignUp(BuildContext context) async {
    // Get AuthProvider instance
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      // If using web, convert Uint8List to File for web handling
      File? imageFile = _selectedImage;
      if (kIsWeb && _webImage != null) {
        // Convert Uint8List to Blob for web
        // Since File.fromRawPath() is not supported on web, you can use a different approach here:
        imageFile = File(_webImage!.toString());
      }

      await authProvider.createUserAccount(
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
        phone: widget.mobileNumber,
        roles: selectedItems,
        password: passwordController.text,
        imageFile: imageFile, // Pass image file if available
      );

      // Navigate to the main screen after successful sign-up
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthWrapper(),
        ),
      );
    } catch (e) {
      print(e.toString());
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
                  key: _formKey, // Assign form key
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Upload a Profile Picture",
                        style: theme.textTheme.displaySmall
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      // Use the ImageInputWidget for image selection
                      ImageInputWidget(
                        onImageSelected:
                            _onImageSelected, // Handle mobile image
                        onWebImageSelected:
                            _onWebImageSelected, // Handle web image
                      ),
                      const SizedBox(height: 20),
                      MultiSelectWidget(
                        items: availableItems,
                        onSelectionChanged:
                            _onSelectionChanged, // Handle selection changes
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
                      PrimaryButtonDark(
                        text: 'Sign Up',
                        onPressed: () => _validateAndSubmit(context),
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
