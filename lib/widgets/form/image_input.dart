import 'dart:io';
import 'dart:typed_data'; // Add this for Uint8List
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImageInputWidget extends StatefulWidget {
  final Function(File?) onImageSelected; // Callback for mobile
  final Function(Uint8List?) onWebImageSelected; // Callback for web

  const ImageInputWidget({
    Key? key,
    required this.onImageSelected,
    required this.onWebImageSelected,
  }) : super(key: key);

  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _selectedImage; // File for mobile
  Uint8List? _webImage; // Uint8List for web

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
          widget.onWebImageSelected(
              _webImage); // Pass image data to parent widget
        } else {
          _showInvalidFileTypeMessage(); // Show error if file type is not supported
          widget.onWebImageSelected(null); // Reset selected image
        }
      } else {
        widget.onWebImageSelected(null); // No image selected
      }
    } else {
      // Handle mobile image picking
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        if (_validateFileType(pickedFile.path.split('.').last)) {
          setState(() {
            _selectedImage = File(pickedFile.path); // Update selected image
          });
          widget.onImageSelected(_selectedImage); // Pass image to parent widget
        } else {
          _showInvalidFileTypeMessage(); // Show error if file type is not supported
          widget.onImageSelected(null); // Reset selected image
        }
      } else {
        widget.onImageSelected(null); // No image selected
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_webImage != null) // Display image on web
          Image.memory(
            _webImage!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          )
        else if (_selectedImage != null) // Display image on mobile
          Image.file(
            _selectedImage!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ],
    );
  }
}
