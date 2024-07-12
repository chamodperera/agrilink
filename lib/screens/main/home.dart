import 'package:agrilink/models/offers_model.dart';
import 'package:agrilink/screens/offer_screen.dart';
import 'package:agrilink/services.dart';
import 'package:agrilink/widgets/buttons/category_button_green.dart';
import 'package:agrilink/widgets/buttons/category_button_grey.dart';
import 'package:agrilink/widgets/buttons/icon_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_light.dart';
import 'package:agrilink/widgets/cards/offer_card.dart';
import 'package:agrilink/widgets/form/search_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Offer>> futureOffers;

  @override
  void initState() {
    super.initState();
    futureOffers = OffersService().fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find Offers",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Expanded(
                  child: AppSearchBar(hintText: 'Search to find offers'),
                ),
                const SizedBox(width: 10),
                IconButtonWidget(
                  icon: FluentIcons.text_grammar_settings_24_regular,
                  onPressed: () {
                    // Add your onPressed logic here
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: const Image(image: AssetImage('assets/images/ad.png')),
            ),
            Row(
              children: [
                CategoryButtonGreen(text: 'All', onPressed: () {}),
                const SizedBox(width: 5),
                CategoryButtonGrey(text: 'Farmers', onPressed: () {}),
                const SizedBox(width: 5),
                CategoryButtonGrey(text: 'Retailers', onPressed: () {}),
                const SizedBox(width: 5),
                CategoryButtonGrey(text: 'Distributors', onPressed: () {}),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Offer>>(
                future: futureOffers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No offers available'));
                  } else {
                    final offers = snapshot.data!;
                    return ListView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
