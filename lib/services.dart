import 'dart:convert';
import 'package:flutter/services.dart';
import 'models/offers_model.dart';

class OffersService {
  Future<List<Offer>> fetchOffers() async {
    final String response = await rootBundle.loadString('data/offers.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Offer.fromJson(json)).toList();
  }
}
