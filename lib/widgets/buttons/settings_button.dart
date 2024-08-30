import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  const SettingsButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
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
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 15),
                Text(text,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
