import 'package:agrilink/widgets/buttons/category_button_green.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrilink/providers/auth_provider.dart';
import 'package:agrilink/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../profile/account.dart'; // Import the account page
import '../profile/plants.dart'; // Import the plants page

class ProfileDashboard extends StatefulWidget {
  final Function(Locale) changeLanguage;

  const ProfileDashboard({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  _ProfileDashboardState createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    final user = authProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 60), // Increased top padding for button space
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: user.roles
                          .map(
                            (role) =>
                                CategoryButtonGreen(text: localizations.translate(role), onPressed: () {}),
                          )
                          .toList(),
                    ),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: user.imageUrl != null
                        ? NetworkImage(user.imageUrl!)
                        : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    user.email,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                    Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 200,
                    width: 375,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(6.927079, 79.861244), // Example coordinates
                        zoom: 10,
                      ),
                      myLocationButtonEnabled: false,
                      ),
                    ),
                    ),
                  const SizedBox(height: 15),
                   
                    const SizedBox(height: 5),
                    Container(
                      child: Column(
                        children: [
                           Text(
                    localizations.translate('Colombo'),
                    style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                            'Colombo is the commercial capital and largest city of Sri Lanka. It is located on the west coast of the island and adjacent to the Greater Colombo area which includes Sri Jayawardenepura Kotte, the legislative capital of Sri Lanka.',
                            style: theme.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                                
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                      colors: [theme.colorScheme.primary, theme.colorScheme.error],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(2), // Border width
                child: SizedBox(
                  width: 345,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PlantsScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onPrimary, 
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      localizations.translate('Start Planning'),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                    ),
                  // Add crops section here
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: IconButton(
              icon: Icon(
                FluentIcons.settings_28_regular,
                color: theme.colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(changeLanguage: widget.changeLanguage),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
