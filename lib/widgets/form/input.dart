import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String text;
  final bool isPassword;

  const TextBox({super.key, required this.text, this.isPassword = false});

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  bool _obscureText = true;

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
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: theme.colorScheme.onSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
