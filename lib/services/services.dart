import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/offers_model.dart';
import '../providers/firebase_provider.dart'; // Import Firestore instance
import '../providers/auth_provider.dart'; // Import AuthProvider to get the current user's UID

class OffersService {
  final FirebaseFirestore _firestore = firestore; // Use Firestore from provider

  OffersService(); // Default constructor

  Future<List<Offer>> fetchOffers(BuildContext context, {String category = 'All'}) async {
    try {
      // Get the AuthProvider from the context
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final String? currentUserUid = authProvider.user?.uid;

      // Log the current user UID to check if it's null
      print('Current User UID: $currentUserUid');

      // Fetch the offers collection from Firestore
      QuerySnapshot querySnapshot = await _firestore.collection('offers').get();

      // Log the number of documents fetched
      print('Number of documents fetched: ${querySnapshot.docs.length}');

      // Parse the Firestore data into a list of Offer objects
      List<Offer> offers = querySnapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Offer.fromJson(data);
          })
          .where((offer) {
            
            return offer.uid != currentUserUid;
          }) // Exclude current user's offers
          .toList();

      // If the category is 'All', return all offers excluding current user's offers
      if (category == 'All') {
        return offers;
      } else {

        // Filter offers by the selected category and exclude current user's offers
        return offers.where((offer) {
          // Log the category of each offer
          return offer.category == category;
        }).toList();
      }
    } catch (e) {
      print('Error fetching offers: $e');
      return [];
    }
  }
}
