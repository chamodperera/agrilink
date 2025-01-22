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

  const ProfileDashboard({Key? key, required this.changeLanguage})
      : super(key: key);

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
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0), // Added padding for the container
              child: Container(
                padding: const EdgeInsets.only(
                    top: 60), // Increased top padding for button space
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: user.roles
                            .map(
                              (role) => CategoryButtonGreen(
                                  text: localizations.translate(role),
                                  onPressed: () {}),
                            )
                            .toList(),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: theme.colorScheme.primary,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: user.imageUrl != null
                            ? NetworkImage(user.imageUrl!)
                            : const AssetImage(
                                    'assets/images/default_profile.png')
                                as ImageProvider,
                      ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(6.9252739,
                                      80.6090552), // Example coordinates
                                  zoom: 10,
                                ),
                                myLocationButtonEnabled: false,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            localizations.translate('Kotagala'),
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Kotagala, located in Sri Lanka's wet zone, has fertile, organic-rich soils with moderate clay content, good drainage, and water-holding capacity, ideal for diverse crops. The area receives moderate to heavy annual rainfall, supporting rain-fed agriculture. However, its slightly acidic soil (pH ~5) necessitates careful nutrient management for optimal crop growth and soil health.",
                            style: theme.textTheme.bodySmall,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.error
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(2), // Border width
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
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
                            // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            localizations.translate('Start Planning'),
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontSize: 16,
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
                    builder: (context) =>
                        ProfileScreen(changeLanguage: widget.changeLanguage),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
