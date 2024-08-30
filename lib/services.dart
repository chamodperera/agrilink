import 'dart:convert';
import 'package:flutter/services.dart';
import 'models/offers_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class OffersService {
  Future<List<Offer>> fetchOffers({String category = 'All'}) async {
    // Load the JSON file from the assets
    final String response = await rootBundle.loadString('data/offers.json');
    final List<dynamic> data = json.decode(response);

    // Parse the JSON data into a list of Offer objects
    List<Offer> offers = data.map((json) => Offer.fromJson(json)).toList();

    // If the category is 'All', return all offers
    if (category == 'All') {
      return offers;
    } else {
      // Filter offers by the selected category
      return offers.where((offer) => offer.category == category).toList();
    }
  }
}
