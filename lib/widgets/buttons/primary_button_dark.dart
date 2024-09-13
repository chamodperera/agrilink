import 'package:flutter/material.dart';

class PrimaryButtonDark extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool expanded;
  final IconData? icon;

  const PrimaryButtonDark({
    Key? key,
    required this.text,
    required this.onPressed,
    this.expanded = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: expanded ? double.infinity : 140,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) 
            Icon(icon!),
            const SizedBox(width: 5),
            Text(
              text,
              style: theme.textTheme.displaySmall?.copyWith(
                fontSize: 16,
                color: theme.colorScheme.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
