import 'package:agrilink/models/offers_model.dart';
import 'package:agrilink/screens/offer_screen.dart';
import 'package:agrilink/services/services.dart'; // Import the OffersService
import 'package:agrilink/widgets/buttons/category_button_green.dart';
import 'package:agrilink/widgets/buttons/category_button_grey.dart';
import 'package:agrilink/widgets/cards/offer_card.dart';
import 'package:agrilink/widgets/form/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Offer>> futureOffers;
  String selectedCategory = 'All'; // State variable for the selected category
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureOffers = fetchOffersByCategory(selectedCategory);
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController
        .dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  // Method to fetch offers based on the selected category
  Future<List<Offer>> fetchOffersByCategory(String category) {
    return OffersService().fetchOffers(context, category: category);
  }

  // Method to update the selected category and fetch offers accordingly
  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
      futureOffers = fetchOffersByCategory(selectedCategory);
    });
  }

  // Method to filter offers based on the search query
  List<Offer> filterOffers(List<Offer> offers) {
    if (searchQuery.isEmpty) {
      return offers;
    } else {
      return offers
          .where((offer) =>
              offer.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              offer.produce.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.translate('find_offers'),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: AppSearchBar(
                      controller: searchController, // Add the controller here
                      hintText: localizations.translate('search'),
                      onSubmitted: (value) {
                        // Add your onSubmitted logic here
                      },
                    ),
                  ),
                  // const SizedBox(width: 10),
                  // IconButtonWidget(
                  //   icon: FluentIcons.text_grammar_settings_24_regular,
                  //   onPressed: () {
                  //     // Add your onPressed logic here
                  //   },
                  // ),
                ],
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: const Image(image: AssetImage('assets/images/ad.png')),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    selectedCategory == 'All'
                        ? CategoryButtonGreen(
                            text: localizations.translate('All'),
                            onPressed: () => updateCategory('All'),
                          )
                        : CategoryButtonGrey(
                            text: localizations.translate('All'),
                            onPressed: () => updateCategory('All'),
                          ),
                    selectedCategory == 'Farmer'
                        ? CategoryButtonGreen(
                            text: localizations.translate('Farmers'),
                            onPressed: () => updateCategory('Farmer'),
                          )
                        : CategoryButtonGrey(
                            text: localizations.translate('Farmers'),
                            onPressed: () => updateCategory('Farmer'),
                          ),
                    selectedCategory == 'Retailer'
                        ? CategoryButtonGreen(
                            text: localizations.translate('Retailers'),
                            onPressed: () => updateCategory('Retailer'),
                          )
                        : CategoryButtonGrey(
                            text: localizations.translate('Retailers'),
                            onPressed: () => updateCategory('Retailer'),
                          ),
                    selectedCategory == 'Distributor'
                        ? CategoryButtonGreen(
                            text: localizations.translate('Distributors'),
                            onPressed: () => updateCategory('Distributor'),
                          )
                        : CategoryButtonGrey(
                            text: localizations.translate('Distributor'),
                            onPressed: () => updateCategory('Distributor'),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              FutureBuilder<List<Offer>>(
                future: futureOffers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No offers available'));
                  } else {
                    final offers = filterOffers(snapshot.data!);
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OfferScreen(offer: offers[index]),
                                  ),
                                );
                              },
                              child: OfferCard(offer: offers[index]),
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
