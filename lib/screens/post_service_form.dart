import 'package:flutter/material.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/services/services.dart';
import 'package:provider/provider.dart'; 

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
            const Positioned(
              top: 40,
              left: 16,
              child: BackButtonWidget(), // Custom back button widget
            ),
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
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[850],
                          hintText: 'Add a title',
                          hintStyle: theme.textTheme.displaySmall?.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18), // Rounded input border
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _subtitleController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[850],
                          hintText: 'Add a subtitle',
                          hintStyle: theme.textTheme.displaySmall?.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18), // Rounded input border
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[850],
                          hintText: 'Description',
                          hintStyle: theme.textTheme.displaySmall?.copyWith(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18), // Rounded input border
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[850],
                                hintText: 'Price',
                                hintStyle: theme.textTheme.displaySmall?.copyWith(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18), // Rounded input border
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
