import 'package:flutter/material.dart';

class PrimaryButtonLight extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButtonLight({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 140,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.displaySmall?.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
