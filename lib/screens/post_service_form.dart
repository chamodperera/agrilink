import 'package:agrilink/widgets/form/dropdown.dart';
import 'package:agrilink/widgets/form/text_input.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/services/services.dart';
import 'package:toastification/toastification.dart';
import 'package:agrilink/app_localizations.dart';

class PostServiceForm extends StatefulWidget {
  const PostServiceForm({Key? key}) : super(key: key);

  @override
  _PostServiceFormState createState() => _PostServiceFormState();
}

class _PostServiceFormState extends State<PostServiceForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _produceController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final List<String> _categories = [
    'Sell produces',
    'Buy produces',
    'Distribution Service'
  ];

  String? _titleError;
  String? _capacityError;
  String? _descriptionError;
  String? _priceError;
  String? _selectedCategory;
  String? _produceError;
  String? _dropdownError;

  @override
  void dispose() {
    _titleController.dispose();
    _capacityController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _produceController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  Future<void> _postService() async {
    setState(() {
      _isLoading = true; // Set isLoading to true
    });

    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final String capacity = _capacityController.text;
    final String price = _priceController.text;
    final String produce = _produceController.text;
    final String category;
    final localizations = AppLocalizations.of(context);


    //set category to farmer if selectedcategory is sell produces
    if (_selectedCategory == 'Sell produces') {
      category = 'Farmer';
    } else if (_selectedCategory == 'Buy produces') {
      category = 'Retailer';
    } else {
      category = 'Distributor';
    }

    setState(() {
      _titleError = title.isEmpty ? localizations.translate('Please enter a title') : null;
      _capacityError = capacity.isEmpty ? localizations.translate('Please enter the capacity') : null;
      _descriptionError =
          description.isEmpty ? localizations.translate('Please enter a description') : null;
      _produceError = produce.isEmpty ? localizations.translate('Please enter the produce') : null;
      _priceError = price.isEmpty ? localizations.translate('Please enter a price') : null;
      _dropdownError =
          _selectedCategory == null ? localizations.translate('Please select a category') : null;
    });

    if (_titleError != null ||
        _capacityError != null ||
        _descriptionError != null ||
        _priceError != null ||
        _produceError != null ||
        _dropdownError != null) {
      setState(() {
        _isLoading = false; // Set isLoading to false
      });
      return; // Stop further execution if validation fails
    }

    // Post the offer using the service
    await OffersService().postOffer(
      context,
      title: title,
      description: description,
      category: category,
      produce: produce,
      capacity: int.tryParse(capacity) ?? 0,
      price: int.tryParse(price) ?? 0,
    );

    print(localizations.translate('service_posted'));

    final theme = Theme.of(context);

    toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: Text(localizations.translate("Success!")),
        description: Text(localizations.translate('offer_made')),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: theme.colorScheme.primary,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        showProgressBar: false);

    Navigator.of(context).pop();
    // Clear the text fields
    _titleController.clear();
    _capacityController.clear();
    _descriptionController.clear();
    _priceController.clear();
    setState(() {
      _selectedCategory = null; // Reset selected category
      _isLoading = false; // Set isLoading to false
    });
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
                "assets/patterns/full.png"), // Add your background image here
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0), // Increased horizontal padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          localizations.translate('Post a Service'),
                          style: theme.textTheme.displayMedium,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextInputField(
                        hintText: localizations.translate('Add a title'),
                        controller: _titleController,
                        errorMessage: _titleError,
                      ),
                      const SizedBox(height: 20),
                      // TextInputField(
                      //   hintText: 'Add a sub title',
                      //   controller: _capacityController,
                      //   errorMessage: _capacityError,
                      // ),

                      DropdownInput(
                        hintText: localizations.translate('Select a category'),
                        items: _categories,
                        selectedItem: _selectedCategory,
                        errorMessage: _dropdownError, // Display error if any
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localizations.translate('Please select a category');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextInputField(
                        hintText: localizations.translate('Enter produce/produces'),
                        controller: _produceController,
                        errorMessage: _produceError,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextInputField(
                              hintText: localizations.translate('Enter the stock/capacity'),
                              controller: _capacityController,
                              errorMessage: _capacityError,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Kg',
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextInputField(
                        hintText:localizations.translate('Description'),
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
                              hintText: localizations.translate('Price per unit'),
                              controller: _priceController,
                              errorMessage: _priceError,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _selectedCategory == 'Distribution Service'
                                ? 'Rs./Km'
                                : 'Rs./Kg',
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: _isLoading
                            ? CircularProgressIndicator() // Show loading indicator
                            : PrimaryButtonDark(
                                text: localizations.translate('Post'),
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
