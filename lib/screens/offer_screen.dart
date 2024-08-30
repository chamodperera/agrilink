import 'package:agrilink/models/offers_model.dart';
import 'package:agrilink/screens/info_screen.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/category_button_green.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/draggable_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class OfferScreen extends StatelessWidget {
  final Offer offer;

  const OfferScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 450,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(offer.avatar),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
              color: theme.colorScheme.background,
            ),
          ),
          const Positioned(
            top: 40, // Adjust the top position as needed
            left: 16, // Adjust the left position as needed
            child: BackButtonWidget(),
          ),
          DraggableWidget(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryButtonGreen(text: offer.category, onPressed: () {}),
                  Row(
                    children: [
                      Text(offer.location,
                          style: theme.textTheme.displaySmall?.copyWith(
                            color: theme.colorScheme.onSecondary,
                          )),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoScreen(offer: offer),
                              ));
                        },
                        child: Icon(FluentIcons.location_28_regular,
                            color: theme.colorScheme.primary),
                      ),
                      const SizedBox(width: 10),
                      Text('19 km',
                          style: theme.textTheme.displaySmall?.copyWith(
                              color: theme.colorScheme.onSecondary,
                              fontSize: 18))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width:
                    double.infinity, // Ensures the Column takes the full width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(offer.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 28,
                        )),
                    Text(offer.subTitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondary,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(FluentIcons.star_three_quarter_28_regular,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Text(offer.rating,
                      style: theme.textTheme.displaySmall?.copyWith(
                          color: theme.colorScheme.onSecondary, fontSize: 18)),
                  const SizedBox(width: 40),
                  Icon(FluentIcons.clipboard_checkmark_24_regular,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 10),
                  Text('10+ offers',
                      style: theme.textTheme.displaySmall?.copyWith(
                          color: theme.colorScheme.onSecondary, fontSize: 18))
                ],
              ),
              const SizedBox(height: 30),
              Text(offer.description,
                  textAlign: TextAlign.justify,
                  style: theme.textTheme.displaySmall?.copyWith(fontSize: 15)),
              const SizedBox(height: 30),
              PrimaryButtonDark(
                text: "Make an offer",
                onPressed: () {},
                expanded: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
