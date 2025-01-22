import 'package:agrilink/models/offers_model.dart';
import 'package:agrilink/screens/offer_screen.dart';
import 'package:agrilink/services/services.dart'; // Import the OffersService
import 'package:agrilink/widgets/buttons/back_button.dart';
// import 'package:agrilink/widgets/buttons/category_button_green.dart';
// import 'package:agrilink/widgets/buttons/category_button_grey.dart';
import 'package:agrilink/widgets/cards/offer_card.dart';
import 'package:agrilink/widgets/form/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/app_localizations.dart';

class DistributorScreen extends StatefulWidget {
  final String? initialCategory;

  const DistributorScreen({Key? key, this.initialCategory}) : super(key: key);

  @override
  _DistributorScreenState createState() => _DistributorScreenState();
}

class _DistributorScreenState extends State<DistributorScreen> {
  late Future<List<Offer>> futureOffers;
  late String selectedCategory;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    selectedCategory =
        'Distributor'; // Initialize with provided category or 'All'
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40), // Add spacing for the back button
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Find a Distributor",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: AppSearchBar(
                          controller: searchController,
                          hintText: '',
                          onSubmitted: (value) {
                            // Add your onSubmitted logic here
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:
                        const Image(image: AssetImage('assets/images/ad.png')),
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
          Positioned(
            top: 40, // Adjust the top position as needed
            left: 16, // Adjust the left position as needed
            child: BackButtonWidget(),
          ),
        ],
      ),
    );
  }
}
