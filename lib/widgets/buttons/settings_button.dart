import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final bool isExpanded;
  final bool isDropdown;

  const SettingsButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.iconColor = const Color(0xFF53E88B),
    this.isExpanded = false,
    this.isDropdown = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 50,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 15),
                Text(text,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                    )),
                if (isDropdown) ...[
                  const Spacer(),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: Icon(
                      FluentIcons.chevron_down_20_regular,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
