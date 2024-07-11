import 'package:flutter/material.dart';
import 'package:agrilink/widgets/cards/offer_card.dart';
import 'package:agrilink/models/offers_model.dart';
// class ServicesScreen extends StatelessWidget {
//   const ServicesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "Services Screen",
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }




// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Service App',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: ServicesScreen(),
//     );
//   }
// }

Offer service = 
  Offer(
    name: "G.Kodikara",
    category: "Farmer",
    avatar: "assets/users/user1.png",
    rating: "4.8",
    location: "Horana",
    title: "Fresh Papayas",
    subTitle: "I have 30 kilos of Papayas.",
    description: "Lorem ipsum dolor sit amet consectetur. Mollis vulputate ultrices pellentesque purus risus auctor. Maecenas viverra magna tellus dolor tellus quam porttitor. Malesuada urna eu ante nec sit tempor odio. Congue nulla turpis non id neque lectus.",
    price: "Rs.200 / km"
  );

List<Offer> offers = [
  Offer(
    name: "S.Gunapala",
    category: "Farmer",
    avatar: "assets/users/user2.png",
    rating: "4.8",
    location: "Ampara",
    title: "Fresh Bananas",
    subTitle: "I have 30kilos of Bananas ",
    description: "Lorem ipsum dolor sit amet consectetur. Mollis vulputate ultrices pellentesque purus risus auctor. Maecenas viverra magna tellus dolor tellus quam porttitor. Malesuada urna eu ante nec sit tempor odio. Congue nulla turpis non id neque lectus.",
    price: "Rs.150 / kg"
  ),
  Offer(
    name: "H.Chandrapala",
    category: "Farmer",
    avatar: "assets/users/user3.png",
    rating: "4.8",
    location: "Polonnarowa",
    title: "Rice",
    subTitle: "I have 100kilos of rice",
    description: "Lorem ipsum dolor sit amet consectetur. Mollis vulputate ultrices pellentesque purus risus auctor. Maecenas viverra magna tellus dolor tellus quam porttitor. Malesuada urna eu ante nec sit tempor odio. Congue nulla turpis non id neque lectus.",
    price: "Rs.80 / kg"
  ),
  Offer(
    name: "G.Kodikara",
    category: "Farmer",
    avatar: "assets/users/user1.png",
    rating: "4.8",
    location: "Horana",
    title: "Fresh Papayas",
    subTitle: "I have 30 kilos of Papayas.",
    description: "Lorem ipsum dolor sit amet consectetur. Mollis vulputate ultrices pellentesque purus risus auctor. Maecenas viverra magna tellus dolor tellus quam porttitor. Malesuada urna eu ante nec sit tempor odio. Congue nulla turpis non id neque lectus.",
    price: "Rs.200 / km"
  )];

class ServicesScreenTop extends StatelessWidget {
  const ServicesScreenTop({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.0),
      
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Post a service',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 121,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.black),
                    SizedBox(height: 10),
                    Text(
                      'Add new service',
                      style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold), 
                      
                    ),
                  ],
                ),
                
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Latest Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Align( 
              alignment: Alignment.centerRight,
              child: TextButton(
              onPressed: () {
                // Add your logic here
              },
              child: const Text(
                'View more',
                style: TextStyle(
                  color: Color.fromARGB(255, 223, 94, 20),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ),
            const SizedBox(height: 5),
            OfferCard(offer: service),
            const SizedBox(height: 10),
             const Text(
              'Your Offers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return Column(
                  children: [
                    OfferCard(offer: offers[index]), 
                    const SizedBox(height: 15),
                  ],
                  );
                },
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}



