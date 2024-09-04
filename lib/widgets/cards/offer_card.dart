import 'package:agrilink/widgets/buttons/forward_button.dart';
import 'package:flutter/material.dart';
import '../../models/offers_model.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(width: 65, image: AssetImage(offer.avatar)),
                  ),
                  const SizedBox(height: 5),
                  Text(offer.name,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      offer.category,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(offer.title,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    const SizedBox(height: 6),
                    Text(offer.subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSecondary,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      'Rs. ${offer.price} ${offer.category == 'distributer' ? '/Km' : '/Kg'}',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 4,
            right: 0,
            child: ForwardButtonWidget(),
          ),
        ],
      ),
    );
  }
}
