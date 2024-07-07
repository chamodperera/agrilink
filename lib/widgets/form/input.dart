import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;

  const TextBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9 > 400
          ? 400
          : MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: theme.colorScheme.onBackground,
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        child: TextField(
          decoration: InputDecoration(
            hintText: text,
            hintStyle: TextTheme(
              bodyMedium: TextStyle(
                color: theme.colorScheme.onSecondary,
              ),
            ).bodyMedium,
          ),
        ),
      ),
    );
  }
}
