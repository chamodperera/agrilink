import 'package:agrilink/screens/profile/plant_detail.dart';
import 'package:flutter/material.dart';

import '../../widgets/buttons/back_button.dart';

class PlantsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> plants = [
    {
      'name': 'Tomato',
      'imageUrl': 'assets/images/tomato.png',
      'category': 'Vegetables',
    },
    {
      'name': 'Carrot',
      'imageUrl': 'assets/images/carrot.png',
      'category': 'Root Vegetables',
    },
    {
      'name': 'Lettuce',
      'imageUrl': 'assets/images/lettuce.png',
      'category': 'Leafy Greens',
    },
    {
      'name': 'Cucumber',
      'imageUrl': 'assets/images/cucumber.png',
      'category': 'Vegetables',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: Text(
                    'My Plants',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: plants.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: plants[index]['name']!,
                          child: PlantCard(
                            plantName: plants[index]['name']!,
                            imageUrl: plants[index]['imageUrl']!,
                            category: plants[index]['category']!,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 40,
              left: 16,
              child: BackButtonWidget(), // Custom back button widget
            ),
          ],
        ),
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final String plantName;
  final String imageUrl;
  final String category;

  const PlantCard({
    required this.plantName,
    required this.imageUrl,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantDetailScreen(
                  plantName: plantName,
                  imageUrl: imageUrl,
                  category: category,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                  child: Image.asset(
                    imageUrl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  plantName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
