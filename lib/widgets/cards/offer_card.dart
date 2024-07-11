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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(children: [
        Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(width: 57, image: AssetImage(offer.avatar)),
          ),
          const SizedBox(height: 5),
          Text(offer.name,
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              offer.category,
              style: GoogleFonts.poppins(
                fontSize: 6,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          
        ]),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(offer.title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                )),
            const SizedBox(height: 10),
            Text(offer.subTitle,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSecondary,
                )),
            const SizedBox(height: 10),
            Text(offer.price,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                )),
          ],
        )
      ]),
    );
  }
}
