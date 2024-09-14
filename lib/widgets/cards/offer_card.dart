import 'package:agrilink/widgets/buttons/forward_button.dart';
import 'package:flutter/material.dart';
import '../../models/offers_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agrilink/app_localizations.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final bool isUser;

  const OfferCard({super.key, required this.offer, this.isUser = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
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
                    child: Image.network(
                      // add user image
                      offer.avatar,
                      width: 65,
                      fit: BoxFit
                          .cover, // Adjust how the image is displayed within the bounds
                    ),
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
                      localizations.translate(offer.category),
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
                    Text(
                        '${offer.category == 'Retailer' ? localizations.translate('I need') : localizations.translate('I have')} ${offer.capacity} ${localizations.translate('Kilos')} ${offer.category == 'Distributor' ? localizations.translate('in capacity') : offer.category == 'Retailer' ? localizations.translate('of produce retailer') : localizations.translate('of produce farmer')}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSecondary,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      'Rs. ${offer.price} ${offer.category == 'Distributor' ? '/Km' : '/Kg'}',
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
          if (!isUser)
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
