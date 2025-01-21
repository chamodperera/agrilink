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
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    // Role buttons
                    Center(
                      child: Wrap(
                        spacing: 8,
                        children: user.roles
                            .map((role) => CategoryButtonGreen(
                                text: localizations.translate(role),
                                onPressed: () {}))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Profile image with decoration
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: theme.colorScheme.primary,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: user.imageUrl != null
                              ? NetworkImage(user.imageUrl!)
                              : const AssetImage('assets/images/default_profile.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Name and email with enhanced styling
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.email,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Enhanced map container
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: 150,
                          width: 325,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(6.927079, 79.861244),
                              zoom: 10,
                            ),
                            myLocationButtonEnabled: false,
                            mapType: MapType.hybrid,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Location information with card styling
                    Column(
                      children: [
                        Text(
                          localizations.translate('Colombo'),
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Text(
                            // Description text
                            '''${localizations.translate('Colombo is the commercial capital and largest city of Sri Lanka. According to the Brookings Institution, Colombo metropolitan area has a population of 5.6 million.')}''',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Enhanced planning button
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
                  width: 330,
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
                
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Settings button remains unchanged
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
      ),
    );
  }
}
