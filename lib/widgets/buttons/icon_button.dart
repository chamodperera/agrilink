import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  IconButtonWidget({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressed, // Border radius for ripple effect
      child: Container(
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius:
              BorderRadius.circular(15.0), // Border radius for button shape
        ),
        padding: const EdgeInsets.all(10.0), // Padding for the icon
        child: Icon(
          size: 28,
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
