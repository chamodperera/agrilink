import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/routes/auth_wrapper.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/screens/authentication/signup_screen_3.dart';
import 'package:provider/provider.dart';
import '../../widgets/form/image_input.dart'; // Import your ImageInputWidget
import '../../providers/auth_provider.dart'; // Import AuthProvider
import '../../widgets/form/dropdown.dart'; // Import your custom DropdownInput widget
import 'package:agrilink/app_localizations.dart';


class SignUp2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
    final Function(Locale) changeLanguage;


  const SignUp2({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.changeLanguage,
  });

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  // Variables for image and role selection
  List<String> selectedItems = []; // Store selected items

  File? _selectedImage; // File for mobile
  Uint8List? _webImage; // Uint8List for web

  String? _districtErrorMessage; // Error message for district validation

  final _formKey = GlobalKey<FormState>();

  // List of districts in Sri Lanka
  final List<String> districts = [
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Colombo',
    'Galle',
    'Gampaha',
    'Hambantota',
    'Jaffna',
    'Kalutara',
    'Kandy',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Monaragala',
    'Mullaitivu',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Trincomalee',
    'Vavuniya'
  ];

  String? _selectedDistrict; // Selected district

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

  void _validateAndNavigate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // If all fields are valid, navigate to SignUp3
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SignUp3(
            firstName: widget.firstName,
            lastName: widget.lastName,
            email: widget.email,
            mobileNumber: widget.mobileNumber,
            district: _selectedDistrict!,
            selectedImage: _selectedImage, // Pass the selected image
            webImage: _webImage, // Pass the web image (if applicable)
            changeLanguage: widget.changeLanguage,
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
                  key: _formKey, // Assign form key
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        localizations.translate('upload_image'),
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
                      const SizedBox(height: 50),
                      Text(
                        "Select Your Location",
                        style: theme.textTheme.displaySmall
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: DropdownInput(
                          hintText: 'Select Location',
                          items: districts,
                          selectedItem: _selectedDistrict,
                          errorMessage: _districtErrorMessage,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedDistrict = newValue;
                              _districtErrorMessage =
                                  null; // Clear error message on change
                            });
                          },
                          validator: (value) =>
                            value == null ? localizations.translate('select_district') : null,
                        ),
                      ),
                      const SizedBox(height: 60),
                      PrimaryButtonDark(
                        text: localizations.translate('next'),
                        onPressed: () => _validateAndNavigate(context),
                      ),
                      // Add other form fields and buttons here
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 20,
              left: 16,
              child: BackButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
