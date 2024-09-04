import 'package:agrilink/widgets/form/dropdown.dart';
import 'package:agrilink/widgets/form/text_input.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/services/services.dart';

class PostServiceForm extends StatefulWidget {
  const PostServiceForm({super.key});

  @override
  _PostServiceFormState createState() => _PostServiceFormState();
}

class _PostServiceFormState extends State<PostServiceForm> {
   final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final List<String> _categories = ['Sell produces', 'Buy produces', 'Distribution Service'];

  String? _titleError;
  String? _subtitleError;
  String? _descriptionError;
  String? _priceError;
  String? _selectedCategory;
  String? _dropdownError;

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _postService() async {
    final String title = _titleController.text;
    final String subtitle = _subtitleController.text;
    final String description = _descriptionController.text;
    final String price = _priceController.text;

    setState(() {
      _titleError = title.isEmpty ? 'Please enter a title' : null;
      _subtitleError = subtitle.isEmpty ? 'Please enter a subtitle' : null;
      _descriptionError = description.isEmpty ? 'Please enter a description' : null;
      _priceError = price.isEmpty ? 'Please enter a price' : null;
    });

    if (_titleError != null || _subtitleError != null || _descriptionError != null || _priceError != null) {
      return; // Stop further execution if validation fails
    }

    // Post the offer using the service
    OffersService().postOffer(
      context,
      title: title,
      description: description,
      subtitle: subtitle, // Assuming subtitle is used as the category
      price: double.tryParse(price) ?? 0.0,
    );

    print('Service Posted Successfully!');

    // Clear the text fields
    _titleController.clear();
    _subtitleController.clear();
    _descriptionController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/patterns/full.png"), // Add your background image here
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0), // Increased horizontal padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        'Post a Service',
                        style: theme.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 30),
                      TextInputField(
                          hintText: 'Add a title',
                          controller: _titleController,
                          errorMessage: _titleError,
                        ),
                      const SizedBox(height: 20),
                      TextInputField(
                          hintText: 'Add a sub title',
                          controller: _subtitleController,
                          errorMessage: _subtitleError,
                        ),
                        const SizedBox(height: 20),
                        DropdownInput(
              hintText: 'Select a Category',
              items: _categories,
              selectedItem: _selectedCategory,
              errorMessage: _dropdownError, // Display error if any
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
                      const SizedBox(height: 20),
                      TextInputField(
                          hintText: 'Description',
                          controller: _descriptionController,
                          errorMessage: _descriptionError,
                          minLines: 6,
                          maxLines: 8,
                          autoExpand: false,
                        ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextInputField(
                                hintText: 'Price',
                                controller: _priceController,
                                errorMessage: _priceError,
                                keyboardType: TextInputType.number,
                              ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Rs./Kg', // Unit text
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: PrimaryButtonDark(
                          text: 'Post',
                          onPressed: _postService,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 40,
              left: 16,
              child: BackButtonWidget(), // Custom back button widget
            ),
          ],
        ),
      ),
    );
  }
}
