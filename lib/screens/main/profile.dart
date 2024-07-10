import 'package:agrilink/widgets/buttons/category_button.dart';
import 'package:agrilink/widgets/buttons/settings_button.dart';
import 'package:agrilink/widgets/draggable_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        child: Stack(
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
                CategoryButton(text: "Farmer", onPressed: () {}),
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
                    SvgPicture.asset('assets/icons/rating.svg'),
                    const SizedBox(width: 8),
                    Text("4.6 Rating",
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                        )),
                  ],
                ),
                SizedBox(height: 40),
                SettingsButton(
                    text: 'Promotions',
                    icon: FluentIcons.chat_warning_20_regular,
                    onPressed: () {}),
                SizedBox(height: 7),
                SettingsButton(
                    text: 'Edit Profile Information',
                    icon: FluentIcons.edit_settings_20_regular,
                    onPressed: () {}),
                SizedBox(height: 7),
                SettingsButton(
                    text: "Settings",
                    icon: FluentIcons.settings_16_regular,
                    onPressed: () {}),
                SizedBox(height: 7),
                SettingsButton(
                    text: "Privacy",
                    icon: FluentIcons.lock_closed_12_regular,
                    onPressed: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
