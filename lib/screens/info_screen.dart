import 'package:agrilink/models/offers_model.dart';
import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'google_maps.dart';

class InfoScreen extends StatelessWidget {
  final Offer offer;

  const InfoScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMapsScreen(address: offer.location+",Sri Lanka"),
          const Positioned(
            top: 40, // Adjust the top position as needed
            left: 16, // Adjust the left position as needed
            child: BackButtonWidget(),
          ),
          Positioned(
            bottom: 15, // Adjust as needed
            left: 20, // Adjust as needed
            right: 20, // Adjust as needed
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align left
                mainAxisSize: MainAxisSize.min, // Take only the available space
                children: [
                  Text(
                    "Discover",
                    style: theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:
                              Image(width: 80, image: AssetImage(offer.avatar)),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(offer.name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              const SizedBox(height: 5),
                              Text(
                                  "Lorem ipsum dolor sit amet consectetur. Leo adipiscing.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: theme.colorScheme.onSecondary,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButtonDark(
                    text: "Call",
                    onPressed: () {},
                    expanded: true,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
