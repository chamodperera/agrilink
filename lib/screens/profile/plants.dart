import 'package:agrilink/screens/profile/plant_detail.dart';
import 'package:flutter/material.dart';

import '../../widgets/buttons/back_button.dart';

class PlantsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> plants = [
    {
      'name': 'Tea',
      'imageUrl': 'assets/images/tea.png',
      'category': 'Cash Crops',
      'description':
          'Tea thrives in cool, wet climates with hilly terrain. The slightly acidic, fertile soil is ideal for producing high-quality tea leaves, making it a key crop in the region.',
    },
    {
      'name': 'Carrot',
      'imageUrl': 'assets/images/carrot.png',
      'category': 'Root Vegetables',
      'description':
          'Carrots grow exceptionally well in cool temperatures and fertile, well-drained soils. They are rich in beta carotene, vitamins, and antioxidants, making them a nutritious choice.',
    },
    {
      'name': 'Avocado',
      'imageUrl': 'assets/images/avocado.png',
      'category': 'Fruits',
      'description':
          'Avocados flourish in fertile, organic-rich soils and areas with moderate rainfall, producing creamy, nutrient-dense fruits rich in healthy fats, vitamins, and minerals.',
    },
    {
      'name': 'Cinnamon',
      'imageUrl': 'assets/images/cinnamon.png',
      'category': 'Spices',
      'description':
          'Cinnamon is well-suited to humid climates and slightly acidic soil. These conditions enhance the flavor and aroma of this highly valued spice.',
    },
    {
      'name': 'Pepper',
      'imageUrl': 'assets/images/pepper.png',
      'category': 'Spices',
      'description':
          'Black pepper vines thrive in well-drained, fertile soil and humid environments. It is a lucrative spice crop with high demand globally.',
    },
    {
      'name': 'Lettuce',
      'imageUrl': 'assets/images/lettuce.png',
      'category': 'Leafy Greens',
      'description':
          'Lettuce grows well in cool and moist climates. Fertile soil supports nutrient-rich leaves that are an excellent source of vitamins A and K.',
    },
    {
      'name': 'Pineapple',
      'imageUrl': 'assets/images/pinapple.png',
      'category': 'Fruits',
      'description':
          'Pineapples grow well in slightly acidic soils and areas with high rainfall. They produce sweet, juicy fruits packed with vitamin C and digestive enzymes.',
    },
    {
      'name': 'Cucumber',
      'imageUrl': 'assets/images/cucumber.png',
      'category': 'Vegetables',
      'description':
          'Cucumbers thrive in well-drained soil and areas with abundant rainfall. They are hydrating, nutrient-rich, and suitable for diverse agricultural conditions.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 30, right: 20),
                  child: Text(
                    "Let's start by choosing a crop",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // add a description
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  child: Text(
                    "Choosing the right crop is essential for a successful harvest. Select a crop to learn more about its growth requirements and benefits.",
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 13),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                  plantDescription: plantDescription,
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
