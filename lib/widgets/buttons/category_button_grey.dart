import 'package:flutter/material.dart';

class CategoryButtonGrey extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CategoryButtonGrey({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.secondary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4), // Reduced padding
            ),
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
