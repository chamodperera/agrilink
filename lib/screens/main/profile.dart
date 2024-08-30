import 'package:agrilink/routes/auth_wrapper.dart';
import 'package:agrilink/widgets/buttons/category_button_green.dart';
import 'package:agrilink/widgets/buttons/primary_button_dark.dart';
import 'package:agrilink/widgets/buttons/settings_button.dart';
import 'package:agrilink/widgets/draggable_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import '../../providers/auth_provider.dart'; // Import AuthProvider

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context,
        listen: false); // Access AuthProvider

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 450,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/users/user1.png'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
              color: theme.colorScheme.background,
            ),
          ),
          DraggableWidget(
            children: [
              CategoryButtonGreen(text: "Farmer", onPressed: () {}),
              Text("Gihan Kodikara",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 30,
                  )),
              Text("gihankodikara@gmail.com",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontSize: 14,
                  )),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FluentIcons.star_three_quarter_28_regular,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text("4.6 Rating",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                      )),
                ],
              ),
              const SizedBox(height: 30),
              SettingsButton(
                  text: 'Promotions',
                  icon: FluentIcons.chat_warning_20_regular,
                  onPressed: () {}),
              const SizedBox(height: 8),
              SettingsButton(
                  text: 'Edit Profile Information',
                  icon: FluentIcons.edit_settings_20_regular,
                  onPressed: () {}),
              const SizedBox(height: 8),
              SettingsButton(
                  text: "Settings",
                  icon: FluentIcons.settings_16_regular,
                  onPressed: () {}),
              const SizedBox(height: 8),
              PrimaryButtonDark(
                  text: 'Sign Out',
                  onPressed: () async {
                    try {
                      await authProvider.signOut(); // Call sign out method
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              const AuthWrapper(), // Navigate to login screen
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to sign out: $e')),
                      );
                    }
                  }),
              // SettingsButton(
              //     text: "Privacy",
              //     icon: FluentIcons.lock_closed_12_regular,
              //     onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }
}
