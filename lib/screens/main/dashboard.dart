import 'package:agrilink/widgets/buttons/icon_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_light.dart';
import 'package:agrilink/widgets/form/search_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/screens/chatbot_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Declare the TextEditingController
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Support",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  // Ensures the search bar takes up available width
                  child: AppSearchBar(
                    controller: searchController, // Add the controller here
                    hintText: 'Need any assistance?',
                    onSubmitted: (inputText) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatbotScreen(initialMessage: inputText),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                IconButtonWidget(
                  icon: FluentIcons.camera_28_regular,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Current Market",
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: const Image(
                          image: AssetImage('assets/images/sales_figure.png')),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Resources",
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 15),
                    Row(children: [
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/fruits_bg.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Maximize Your Harvest',
                                    style:
                                        theme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  PrimaryButtonLight(
                                      text: "Learn More", onPressed: () {})
                                ],
                              ))),
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/green_house.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Trends',
                                    style:
                                        theme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  PrimaryButtonLight(
                                      text: "Learn More", onPressed: () {})
                                ],
                              ))),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
