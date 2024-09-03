import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleMapsScreen extends StatefulWidget {
  final String address;

  GoogleMapsScreen({required this.address});

  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  GoogleMapController? _mapController;
  LatLng? _center;

  Future<LatLng> fetchLocation(String address) async {
    final apiKey = 'AIzaSyDkx-MW3NTp7K7dcD5mf2cN4-ShtTnPw1s'; // Replace with your Google API key
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'OK') {
        final location = jsonResponse['results'][0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        return LatLng(lat, lng);
      } else {
        throw Exception('Failed to fetch location');
      }
    } else {
      throw Exception('Failed to fetch location');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLocation(widget.address).then((location) {
      setState(() {
        _center = location;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _center == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _center!,
                zoom: 14.0,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
             circles: {
                Circle(
                  circleId: CircleId('selected-location'),
                  center: _center!,
                  radius: 1000, // Radius in meters
                  fillColor: Colors.blue.withOpacity(0.5),
                  strokeColor: Colors.blue,
                  strokeWidth: 1,
                ),
              },
            ),
    );
  }
}