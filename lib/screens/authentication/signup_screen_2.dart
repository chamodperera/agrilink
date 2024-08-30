import 'dart:io';
import 'dart:typed_data';
import 'package:agrilink/screens/authentication/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/logo.dart';
import 'package:agrilink/widgets/form/input.dart';
import 'package:agrilink/widgets/form/validators.dart';
import '../../widgets/form/image_input.dart'; // Import your ImageInputWidget
import '../../widgets/form/multi_select.dart'; // Import your MultiSelectWidget

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  //for select role
  final List<String> availableItems = ['Farmer', 'Distributor', 'Retailer'];
  List<String> selectedItems = []; // Store selected items

  void _onSelectionChanged(List<String> selectedList) {
    setState(() {
      selectedItems = selectedList; // Update selected items
    });
  }
  // File? _selectedImage; // File for mobile
  // Uint8List? _webImage; // Uint8List for web

  // // Method to handle image selection for mobile
  // void _onImageSelected(File? image) {
  //   setState(() {
  //     _selectedImage = image;
  //   });
  // }

  // // Method to handle image selection for web
  // void _onWebImageSelected(Uint8List? imageBytes) {
  //   setState(() {
  //     _webImage = imageBytes;
  //   });
  // }

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
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text("Select preferred roles",
                        style: theme.textTheme.displaySmall
                            ?.copyWith(fontSize: 18)),
                    const SizedBox(height: 10),
                    // Use the ImageInputWidget
                    // ImageInputWidget(
                    //   onImageSelected: _onImageSelected, // Handle mobile image
                    //   onWebImageSelected:
                    //       _onWebImageSelected, // Handle web image
                    // ),
                    // // Display the selected image
                    // if (_webImage != null)
                    //   Image.memory(
                    //     _webImage!,
                    //     width: 100,
                    //     height: 100,
                    //     fit: BoxFit.cover,
                    //   )
                    // else if (_selectedImage != null)
                    //   Image.file(
                    //     _selectedImage!,
                    //     width: 100,
                    //     height: 100,
                    //     fit: BoxFit.cover,
                    //   ),
                    MultiSelectWidget(
                      items: availableItems,
                      onSelectionChanged:
                          _onSelectionChanged, // Handle selection changes
                    ),
                    const SizedBox(height: 20),
                    const TextBox(
                      text: 'Password',
                      isPassword: true,
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 10),
                    const TextBox(
                      text: 'Re-enter Password',
                      isPassword: true,
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 30),
                    PrimaryButtonDark(
                      text: 'Sign Up',
                      onPressed: () {
                        // Add logic to validate passwords and navigate
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                    )
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
