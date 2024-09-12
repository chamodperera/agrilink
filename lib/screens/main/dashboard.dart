import 'package:agrilink/widgets/buttons/icon_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_light.dart';
import 'package:agrilink/widgets/form/search_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:agrilink/screens/chatbot_screen.dart';
import 'package:agrilink/app_localizations.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      // Added Scaffold to provide proper layout
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.translate('support'),
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  // Ensures the search bar takes up available width
                  child: AppSearchBar(
                    hintText: localizations.translate('ask_agribot'),
                    onSubmitted: (inputText) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatbotScreen(initialMessage: inputText),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                IconButtonWidget(
                  icon: FluentIcons.camera_28_regular,
                  onPressed: () {}
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      localizations.translate("current_market"),
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
                      localizations.translate("resources"),
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
                                    localizations.translate("learn_more"),
                                    style:
                                        theme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  PrimaryButtonLight(
                                      text: localizations.translate("learn_more"), onPressed: () {})
                                ],
                              )))
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
                                    localizations.translate("current_trends"),
                                    style:
                                        theme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  PrimaryButtonLight(
                                      text: localizations.translate("learn_more"), onPressed: () {})
                                ],
                              )))
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
