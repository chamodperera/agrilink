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
import 'package:agrilink/app_localizations.dart';



class ProfileScreen extends StatefulWidget {
  final Function(Locale) changeLanguage;


  const ProfileScreen({Key? key, required this.changeLanguage}) : super(key: key);

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

  bool _isLanguageExpanded = false;
  Locale get currentLocale => Localizations.localeOf(context);
  @override
  Widget build(BuildContext context) {
    // Mocked authProvider for example purposes
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    final user = authProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    IconData _selectIcon(String languageCode) {
    return currentLocale.languageCode == languageCode
        ? FluentIcons.checkbox_checked_16_regular
        : FluentIcons.checkbox_unchecked_12_regular;
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
                            CategoryButtonGreen(text: localizations.translate(role), onPressed: () {}),
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
                    "4.6 ${localizations.translate('rating')}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SettingsButton(
                text: localizations.translate('edit_profile_one'),
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
                text: localizations.translate('change_language'),
                icon: FluentIcons.local_language_16_regular,
                iconColor: theme.colorScheme.primary,
                isDropdown: true,
                onPressed: () => setState(() {
                  _isLanguageExpanded = !_isLanguageExpanded;
                }),
                expandedItems: [
                SettingsButton(
                  text: 'English',
                  icon: _selectIcon('en'),
                  radius: 0,
                  onPressed: () {
                    widget.changeLanguage(const Locale('en'));
                    setState(() {
                      _isLanguageExpanded = false;
                    });
                  },
                ),
                SettingsButton(
                  text: 'සිංහල',
                  icon: _selectIcon('si'),
                  radius: 0,
                  onPressed: () {
                    widget.changeLanguage(const Locale('si'));
                    setState(() {
                      _isLanguageExpanded = false;
                    });
                  },
                ),
                SettingsButton(
                  text: 'தமிழ்',
                  icon: _selectIcon('ta'),
                  radius: 0,
                  lastItem: true,
                  onPressed: () {
                    widget.changeLanguage(const Locale('ta'));
                    setState(() {
                      _isLanguageExpanded = false;
                    });
                  },
                ),                
                ],
              ),
              const SizedBox(height: 8),
              SettingsButton(
                text: localizations.translate('settings'),
                icon: FluentIcons.settings_16_regular,
                iconColor: theme.colorScheme.primary,
                isDropdown: true,
                expandedItems: [
                  SettingsButton(
                  icon: FluentIcons.sign_out_20_regular,
                  radius: 0,
                  text: localizations.translate('sign_out'),
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
                        SnackBar(content: Text(localizations.translate('failed_sign_out') + e.toString())),
                      );
                    }
                  },
                ),
                SettingsButton(
                  text: localizations.translate('delete_account'),
                  icon: FluentIcons.delete_20_regular,
                  iconColor: theme.colorScheme.error,
                  radius: 0,
                  lastItem: true,
                  onPressed: () async {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(localizations.translate('delete_account')),
                        content: const Text(
                            'Are you sure you want to delete your account? This action cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  }
                ),
                ],
                onPressed: () {
                  setState(() {
                    _isSettingsExpanded = !_isSettingsExpanded;

                  });
                },
              ),
              ],
            // ],
          ),
        ],
      ),
    );
  }
}
