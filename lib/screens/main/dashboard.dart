import 'dart:io';
// import 'package:agrilink/theme/theme.dart';
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
// import 'package:agrilink/widgets/line_chart.dart';
// import 'package:agrilink/services/services.dart';
// import 'package:intl/intl.dart'; // For date formatting

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController forcastController = TextEditingController();
  File? _selectedImage; // Variable to store the captured image for mobile
  Uint8List? _webImage; // Variable to store the image for web
  // Map<dynamic, dynamic> _forecastData = {}; // Store fetched forecast data
  // bool _isLoadingForecast = true; // Loading indicator for forecast data

  final ImagePicker _picker =
      ImagePicker(); // Create an instance of ImagePicker

  // final ForecastService _forecastService =
  //     ForecastService(); // Instantiate ForecastService

  // DateTime? selectedDate; // For storing selected month

  // Map<String, double> filteredAvgPrices = {}; // To store filtered prices

  @override
  void initState() {
    super.initState();

    // Set the selectedDate to the current month
    // final now = DateTime.now();
    // selectedDate = DateTime(now.year, now.month);

    // _fetchForecastData(); // Fetch forecast data when the widget loads
  }

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
                location: 'Aluthgama',
                district: 'Anuradhapura',
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
                location: 'Aluthgama',
                district: 'Anuradhapura',
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

  // Fetch forecast data from the ForecastService
  // Future<void> _fetchForecastData() async {
  //   final data = await _forecastService.fetchForcastData();
  //   setState(() {
  //     _forecastData = data;
  //     _isLoadingForecast = false; // Data fetched, stop loading

  //     // Filter data if a month is selected
  //     if (selectedDate != null) {
  //       _filterDataByMonth();
  //     }
  //   });
  // }

  // // Method to filter data by the selected month
  // void _filterDataByMonth() {
  //   if (selectedDate != null && _forecastData.containsKey('avgPrice')) {
  //     // Clear previously filtered data
  //     filteredAvgPrices.clear();

  //     // Aggregate by day and filter by the selected month
  //     Map<String, List<double>> tempData = {};

  //     _forecastData['avgPrice'].forEach((date, price) {
  //       try {
  //         final DateTime entryDate = DateFormat('yyyy-MM-dd').parse(date);
  //         if (entryDate.year == selectedDate!.year &&
  //             entryDate.month == selectedDate!.month) {
  //           final day = entryDate.day.toString();

  //           // Aggregate prices by day
  //           if (tempData.containsKey(day)) {
  //             tempData[day]!.add(price);
  //           } else {
  //             tempData[day] = [price];
  //           }
  //         }
  //       } catch (e) {
  //         print(e.toString());
  //       }
  //     });

  //     // Calculate average prices for duplicate days
  //     tempData.forEach((day, prices) {
  //       final avgPrice = prices.reduce((a, b) => a + b) / prices.length;
  //       filteredAvgPrices[day] = avgPrice;
  //     });
  //   }
  // }

  Future<void> _redirect(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  // Method to show month picker
  // Future<void> _selectMonth(BuildContext context) async {
  //   final now = DateTime.now();
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime(now.year, now.month),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(now.year + 1),
  //     builder: (context, child) {
  //       final theme = Theme.of(context);

  //       return Theme(
  //         data: theme.copyWith(
  //           colorScheme: theme.colorScheme.copyWith(
  //             primary: theme
  //                 .colorScheme.primary, // Use primary color for selected date
  //             onPrimary:
  //                 Colors.black, // Ensure selected date text is visible (white)
  //             surface: theme
  //                 .colorScheme.secondary, // Set background color of the dialog
  //             onSurface: Colors.white, // Set text color for unselected dates
  //           ),
  //           dialogBackgroundColor: Colors.white, // Dialog background color
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (pickedDate != null) {
  //     setState(() {
  //       selectedDate = DateTime(pickedDate.year, pickedDate.month);
  //       _filterDataByMonth(); // Filter data based on the newly selected month
  //     });
  //   }
  // }

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
                    hintText: localizations.translate('Ask hor help'),
                    onSubmitted: (inputText) {
                      if (inputText.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatbotScreen(
                              initialMessage: inputText,
                              location: 'Aluthgama',
                              district: 'Anuradhapura',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                IconButtonWidget(
                  icon: FluentIcons.send_28_regular,
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatbotScreen(
                            initialMessage: searchController.text,
                            location: 'Aluthgama',
                            district: 'Anuradhapura',
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: const Image(
                          image: AssetImage('assets/images/ad.png')),
                    ),
                    // const SizedBox(height: 10),
                    // Text(
                    //   localizations.translate("current_market"),
                    //   style: theme.textTheme.titleMedium,
                    // ),
                    // const SizedBox(height: 15),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: AppSearchBar(
                    //         controller: forcastController,
                    //         hintText: localizations.translate('Search Market'),
                    //         onSubmitted: (inputText) {},
                    //       ),
                    //     ),
                    //     const SizedBox(width: 10),
                    //     IconButtonWidget(
                    //       icon: FluentIcons.filter_28_regular,
                    //       onPressed: () => _selectMonth(context),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 15),
                    // _isLoadingForecast
                    //     ? Center(child: CircularProgressIndicator())
                    //     : MarketChart(
                    //         chartData: {
                    //           "dataPoints": filteredAvgPrices.entries
                    //               .map((entry) => {
                    //                     "x": double.parse(
                    //                         entry.key), // Day of month
                    //                     "y": entry.value
                    //                   })
                    //               .toList(),
                    //         },
                    //         produceName: "Carrots",
                    //       ),
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
                                    localizations.translate("maximize_harvest"),
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
                    const SizedBox(height: 30),
                    Row(children: [
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/technician.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Talk with an Expert",
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
