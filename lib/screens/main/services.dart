import 'package:agrilink/screens/onboarding/services_screen_top.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/widgets/cards/offer_card.dart';
import 'package:agrilink/models/offers_model.dart';



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
          image: AssetImage('assets/patterns/Right_quater.png'), // Replace with your pattern image asset
          alignment: Alignment.topRight,
          
        ),
      ),
    ),
    const ServicesScreenTop(),
  ],
  );
  }
}