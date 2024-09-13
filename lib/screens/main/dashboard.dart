import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart'; // For image selection
import 'package:file_picker/file_picker.dart'; // For web image picking
import 'package:agrilink/widgets/buttons/icon_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_light.dart';
import 'package:agrilink/widgets/form/search_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:agrilink/screens/chatbot_screen.dart';
import 'package:agrilink/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController searchController = TextEditingController();
  File? _selectedImage; // Variable to store the captured image for mobile
  Uint8List? _webImage; // Variable to store the image for web

  final ImagePicker _picker =
      ImagePicker(); // Create an instance of ImagePicker

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Method to pick image from mobile camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    if (kIsWeb) {
      // Handle web image picking
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg'], // Restrict to PNG and JPG
      );

      if (result != null && result.files.single.bytes != null) {
        if (_validateFileType(result.files.single.extension)) {
          setState(() {
            _webImage = result.files.single.bytes; // Use Uint8List for web
          });
          // Navigate to ChatbotScreen and pass the web image
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatbotScreen(
                initialMessage: searchController.text,
                webImage: _webImage, // Pass the web image
              ),
            ),
          );
        } else {
          _showInvalidFileTypeMessage(); // Show error if file type is not supported
        }
      }
    } else {
      // Handle mobile image picking (camera or gallery)
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        if (_validateFileType(pickedFile.path.split('.').last)) {
          setState(() {
            _selectedImage = File(pickedFile.path); // Update selected image
          });
          // Navigate to ChatbotScreen and pass the mobile image
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatbotScreen(
                initialMessage: searchController.text,
                capturedImage: _selectedImage, // Pass the mobile image
              ),
            ),
          );
        } else {
          _showInvalidFileTypeMessage(); // Show error if file type is not supported
        }
      }
    }
  }

  bool _validateFileType(String? extension) {
    // Validate file type
    return extension != null &&
        (extension.toLowerCase() == 'png' ||
            extension.toLowerCase() == 'jpg' ||
            extension.toLowerCase() == 'jpeg');
  }

  void _showInvalidFileTypeMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select a PNG or JPG image.')),
    );
  }

  Future<void> _redirect(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.translate('support'),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: AppSearchBar(
                    controller:
                        searchController, // Add the required 'controller' argument
                    hintText: localizations.translate('ask_agribot'),
                    onSubmitted: (inputText) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatbotScreen(
                            initialMessage: inputText,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                IconButtonWidget(
                    icon: FluentIcons.camera_28_regular,
                    onPressed: () => _pickImage(ImageSource.camera)),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      localizations.translate("current_market"),
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: const Image(
                          image: AssetImage('assets/images/sales_figure.png')),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      localizations.translate("resources"),
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 15),
                    Row(children: [
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/fruits_bg.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localizations.translate("learn_more"),
                                    style:
                                        theme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  PrimaryButtonLight(
                                      text:
                                          localizations.translate("learn_more"),
                                      onPressed: () async {
                                        await _redirect(
                                            'https://www.trade.gov/country-commercial-guides/sri-lanka-agricultural-sector'); // Replace with your link
                                      })
                                ],
                              ))),
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/green_house.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localizations.translate("current_trends"),
                                    style:
                                        theme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  PrimaryButtonLight(
                                      text:
                                          localizations.translate("learn_more"),
                                      onPressed: () async {
                                        await _redirect(
                                            'https://www.srilankabusiness.com/fruits-and-vegetables/exporter-information/new-agriculture-trends.html'); // Replace with your link
                                      })
                                ],
                              ))),
                    ]),
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
