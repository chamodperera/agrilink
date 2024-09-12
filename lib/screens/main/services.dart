import 'package:agrilink/models/request_model.dart';
import 'package:agrilink/screens/info_screen.dart';
import 'package:agrilink/screens/post_service_form.dart';
import 'package:agrilink/services/services.dart';
import 'package:agrilink/widgets/cards/request_card.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/cards/offer_card.dart';
import 'package:agrilink/models/offers_model.dart';
import 'package:agrilink/app_localizations.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late Stream<List<Offer>> offerStream;
  late Stream<List<Request>> requestStream;

  @override
  void initState() {
    super.initState();
    offerStream = OffersService().fetchUserOffers(context);
    requestStream = OffersService().fetchUserRequests(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        // Make the entire screen scrollable
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/patterns/Right_quater.png'), // Replace with your pattern image asset
                  alignment: Alignment.topRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.translate("post_service"),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PostServiceForm(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(FluentIcons.add_circle_32_regular,
                              size: 36, color: Colors.black),
                          const SizedBox(height: 10),
                          Text(localizations.translate("add_service"),
                              style: theme.textTheme.displaySmall?.copyWith(
                                fontSize: 14,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    localizations.translate("latest_services"),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<List<Offer>>(
                    stream: offerStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text(localizations.translate('no_offers'),
                                style: theme.textTheme.displaySmall?.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                )));
                      } else {
                        final offers = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
                          padding: EdgeInsets.zero,
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                OfferCard(offer: offers[index],isUser: true,),
                                const SizedBox(height: 15),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    localizations.translate("requests"),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<List<Request>>(
                    stream: requestStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text(localizations.translate('no_requests'),
                                style: theme.textTheme.displaySmall?.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                )));
                      } else {
                        final requests = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable scrolling for inner ListView
                          padding: EdgeInsets.zero,
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InfoScreen(
                                              location:
                                                  requests[index].location,
                                              avatar: requests[index].avatar,
                                              name: requests[index].name),
                                        ));
                                  },
                                  child: RequestCard(request: requests[index]),
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
          ],
        ),
      ),
    );
  }
}
