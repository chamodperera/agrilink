import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'google_maps.dart';
import 'package:agrilink/app_localizations.dart';

class InfoScreen extends StatelessWidget {
  final String location;
  final String avatar;
  final String name;
  final String description;
  final String phone;

  const InfoScreen(
      {super.key,
      required this.location,
      required this.avatar,
      required this.name, 
      this.description = '',
      required this.phone});

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Add your call logic here
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMapsScreen(address: location + ",Sri Lanka"),
          const Positioned(
            top: 40, // Adjust the top position as needed
            left: 16, // Adjust the left position as needed
            child: BackButtonWidget(),
          ),
          Positioned(
            bottom: 15, // Adjust as needed
            left: 20, // Adjust as needed
            right: 20, // Adjust as needed
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align left
                mainAxisSize: MainAxisSize.min, // Take only the available space
                children: [
                  Text(
                    localizations.translate('Discover'),
                    style: theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            avatar,
                            width: 80,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error, size: 80);
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              const SizedBox(height: 5),
                              Text(
                                  description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: theme.colorScheme.onSecondary,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButtonDark(
                    icon: FluentIcons.call_16_regular,
                    text: localizations.translate('Call'),
                    onPressed: () {
                      // Add your call logic here
                      _makePhoneCall(phone);
                    },
                    expanded: true,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
