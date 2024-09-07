import 'package:agrilink/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/offers_model.dart';
import '../providers/firebase_provider.dart'; // Import Firestore instance
import '../providers/auth_provider.dart'; // Import AuthProvider to get the current user's UID

class OffersService {
  final FirebaseFirestore _firestore = firestore; // Use Firestore from provider

  OffersService(); // Default constructor

  Future<List<Offer>> fetchOffers(BuildContext context,
      {String category = 'All'}) async {
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
      List<Offer> offers = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Offer.fromJson(data);
      }).where((offer) {
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

  Stream<List<Offer>> fetchUserOffers(BuildContext context) {
    // Get the AuthProvider from the context
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? currentUserUid = authProvider.user?.uid;

    // Log the current user UID to check if it's null
    print('Current User UID: $currentUserUid');

    // Return a stream that listens to changes in the offers collection
    return _firestore
        .collection('offers')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      // Log the number of documents fetched
      print('Number of documents fetched: ${querySnapshot.docs.length}');

      // Parse the Firestore data into a list of Offer objects
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Offer.fromJson(data);
      }).where((offer) {
        return offer.uid == currentUserUid;
      }).toList();
    });
  }

  Stream<List<Request>> fetchUserRequests(BuildContext context) {
    // Get the AuthProvider from the context
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? currentUserUid = authProvider.user?.uid;

    // Log the current user UID to check if it's null
    print('Current User UID: $currentUserUid');

    // Return a stream that listens to changes in the offers collection
    return _firestore
        .collection('users')
        .doc(currentUserUid)
        .collection('requests')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      // Log the number of documents fetched
      print('Number of documents fetched: ${querySnapshot.docs.length}');

      // Parse the Firestore data into a list of Offer objects
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return Request.fromJson(data);
      }).toList();
    });
  }

  // Method to post a new offer
  Future<void> postOffer(
    BuildContext context, {
    required String title,
    required String description,
    required int capacity,
    required String category,
    required int price,
  }) async {
    try {
      // Get the AuthProvider from the context
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final String? currentUserUid = authProvider.user?.uid;
      final String? currentUserName = authProvider.user?.firstName;
      final String? currentUserLocation = authProvider.user?.location;
      final String? currentUserAvatar =
          authProvider.user?.imageUrl ?? 'assets/users/user.png';

      if (currentUserUid == null || currentUserName == null) {
        print('User is not logged in');
        return;
      }

      // Create a new offer document
      await _firestore.collection('offers').add({
        'uid': currentUserUid,
        'name': currentUserName,
        'avatar': currentUserAvatar,
        'rating': '4.6',
        'location': currentUserLocation,
        'title': title,
        'description': description,
        'category': category,
        'capacity': capacity,
        'price': price
      });

      print('Offer posted successfully');
    } catch (e) {
      print('Error posting offer: $e');
    }
  }

  Future<void> placeOffer(
    BuildContext context, {
    required String offerUid,
    required String offerTitle,
    required String offerCategory,
    required int amount,
    required int negotiatedPrice,
  }) async {
    try {
      // Get the AuthProvider from the context
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final String? currentUserUid = authProvider.user?.uid;
      final String? currentUserName = authProvider.user?.firstName;
      final String? currentUserLocation = authProvider.user?.location;
      final String? currentUserAvatar =
          authProvider.user?.imageUrl ?? 'assets/users/user.png';

      if (currentUserUid == null || currentUserName == null) {
        print('User is not logged in');
        return;
      }

      // Create a new offer document
      await _firestore
          .collection('users')
          .doc(offerUid)
          .collection('requests')
          .add({
        'uid': currentUserUid,
        'name': currentUserName,
        'avatar': currentUserAvatar,
        'rating': '4.6',
        'location': currentUserLocation,
        'title': offerTitle,
        'category': offerCategory,
        'amount': amount,
        'negotiatedPrice': negotiatedPrice,
      });

      print('Offer posted successfully');
    } catch (e) {
      print('Error posting offer: $e');
    }
  }
}
