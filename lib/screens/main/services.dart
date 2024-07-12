import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/cards/offer_card.dart';
import 'package:agrilink/models/offers_model.dart';

Offer service = Offer(
    name: "G.Kodikara",
    category: "Farmer",
    avatar: "assets/users/user1.png",
    rating: "4.8",
    location: "Horana",
    title: "Fresh Papayas",
    subTitle: "I have 30 kilos of Papayas.",
    description:
        "Lorem ipsum dolor sit amet consectetur. Mollis vulputate ultrices pellentesque purus risus auctor. Maecenas viverra magna tellus dolor tellus quam porttitor. Malesuada urna eu ante nec sit tempor odio. Congue nulla turpis non id neque lectus.",
    price: "Rs.170/kg");

List<Offer> offers = [
  Offer(
      name: "L.Kanthi",
      category: "Retailer",
      avatar: "assets/users/user4.png",
      rating: "4.8",
      location: "Ampara",
      title: "10 kilos of Bananas",
      subTitle: "I need 10kilos of Bananas ",
      description:
          "Lorem ipsum dolor sit amet consectetur. Mollis vulputate ultrices pellentesque purus risus auctor. Maecenas viverra magna tellus dolor tellus quam porttitor. Malesuada urna eu ante nec sit tempor odio. Congue nulla turpis non id neque lectus.",
      price: "Rs.120/kg"),
];

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
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
                'Post a service',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 120,
                child: ElevatedButton(
                  onPressed: () {},
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
                      Text('Add new service',
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
                'Your Latest Services',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              OfferCard(offer: service),
              const SizedBox(height: 30),
              Text(
                'Your Offers',
                style: theme.textTheme.titleMedium,
              ),
              // const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        OfferCard(offer: offers[index]),
                        // const SizedBox(height: 15),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
