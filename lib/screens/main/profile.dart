import 'package:agrilink/widgets/buttons/category_button_green.dart';
import 'package:agrilink/widgets/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrilink/providers/auth_provider.dart';
import 'package:agrilink/routes/auth_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agrilink/widgets/buttons/settings_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import '../profile/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  final Function(Locale) changeLanguage;

  const ProfileScreen({Key? key, required this.changeLanguage})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSettingsExpanded = false; // Ensure the state is properly initialized

  Future<void> _redirect(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mocked authProvider for example purposes
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    final user = authProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 450,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: user.imageUrl != null && user.imageUrl!.isNotEmpty
                    ? NetworkImage(user.imageUrl!)
                    : const AssetImage('assets/users/user.png')
                        as ImageProvider,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
              color: theme.colorScheme.background,
            ),
          ),
          DraggableWidget(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: user.roles
                      .map(
                        (role) =>
                            CategoryButtonGreen(text: role, onPressed: () {}),
                      )
                      .toList(),
                ),
              ),
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
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.star_three_quarter_28_regular,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "4.6 Rating",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SettingsButton(
                text: 'Edit Profile Information',
                icon: FluentIcons.edit_settings_20_regular,
                iconColor: theme.colorScheme.primary,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              SettingsButton(
                text: "Settings",
                icon: FluentIcons.settings_16_regular,
                iconColor: theme.colorScheme.primary,
                isDropdown: true,
                isExpanded: _isSettingsExpanded,
                onPressed: () {
                  setState(() {
                    _isSettingsExpanded = !_isSettingsExpanded;
                  });
                },
              ),
              if (_isSettingsExpanded) ...[
                const SizedBox(height: 8),
                SettingsButton(
                  icon: FluentIcons.sign_out_20_regular,
                  text: 'Sign Out',
                  onPressed: () async {
                    try {
                      await authProvider.signOut(); // Call sign out method
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => AuthWrapper(
                            changeLanguage: widget.changeLanguage,
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to sign out: $e')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
                SettingsButton(
                  text: "Delete My Account",
                  icon: FluentIcons.delete_20_regular,
                  iconColor: theme.colorScheme.error,
                  onPressed: () async {
                    await _redirect(
                        'https://docs.google.com/forms/d/e/1FAIpQLSeuoPUeY0m1qP9clRAHLLQYFJotZjqX0x9xlLMcMlJEyRkGLQ/viewform');
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
