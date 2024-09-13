import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/form/image_input.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:agrilink/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  File? _profileImage;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _isLoading = true;
      });
      await _updateProfileImage();
    }
  }

  Future<void> _updateProfileImage() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (_profileImage != null) {
        await authProvider.updateUserImage(_profileImage!);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile image updated',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile image: $e'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // update profile first name and lastname
  Future<void> _updateProfile() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;

      if (user == null) {
        throw Exception('No user is currently signed in.');
      }

      // Update user's first name and last name in Firestore
      await authProvider.updateUserProfile(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );

      // Reload user to apply changes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile information saved',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile information: $e'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user != null) {
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.translate('Edit Profile'),
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Opacity(
                          opacity: 0.6,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: user.imageUrl != null &&
                                    user.imageUrl!.isNotEmpty
                                ? NetworkImage(user.imageUrl!)
                                : const AssetImage('assets/users/user.png')
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      if (_isLoading) const CircularProgressIndicator(),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: _pickImage,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: "First Name",
                    ),
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: PrimaryButtonDark(
                        text: 'Save',
                        onPressed: () {
                          _updateProfile();                          
                        }),
                  ),
                ],
              ),
            ),
            Positioned(
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
