import 'package:agrilink/screens/profile/plant_detail.dart';
import 'package:flutter/material.dart';

import '../../widgets/buttons/back_button.dart';

class PlantsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> plants = [
    {
      'name': 'Tomato',
      'imageUrl': 'assets/images/tomato.png',
      'category': 'Vegetables',
      'description': 'Tomatoes are the major dietary source of the antioxidant lycopene, which has been linked to many health benefits, including reduced risk of heart disease and cancer. They are also a great source of vitamin C, potassium, folate, and vitamin K.',
    },
    {
      'name': 'Carrot',
      'imageUrl': 'assets/images/carrot.png',
      'category': 'Root Vegetables',
      'description': 'Carrots are a particularly good source of beta carotene, fiber, vitamin K1, potassium, and antioxidants. They also have a number of health benefits. They’re a weight-loss-friendly food and have been linked to lower cholesterol levels and improved eye health.',
    },
    {
      'name': 'Lettuce',
      'imageUrl': 'assets/images/lettuce.png',
      'category': 'Leafy Greens',
      'description': 'Lettuce is a good source of vitamins A and K. It also provides some fiber, iron, and folate. It is a low-calorie food that is high in nutrients and water content, making it an excellent food for weight loss.',
    },
    {
      'name': 'Cucumber',
      'imageUrl': 'assets/images/cucumber.png',
      'category': 'Vegetables',
      'description': 'Cucumbers are low in calories but high in many important vitamins and minerals. They contain antioxidants, promote hydration, and may aid in weight loss.',
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
                            plantDescription: plants[index]['description']!,
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
  final String plantDescription;

  const PlantCard({
    required this.plantName,
    required this.imageUrl,
    required this.category,
    required this.plantDescription,
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
                  plantDescription: plantDescription,),
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
