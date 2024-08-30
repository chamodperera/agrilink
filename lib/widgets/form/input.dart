import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String text;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? errorMessage; // Error message from parent

  const TextBox({
    super.key,
    required this.text,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.errorMessage, // Add this parameter
  });

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  bool _obscureText = true;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

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
        child: TextFormField(
          controller: _controller,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
            errorText:
                widget.errorMessage, // Display external error if provided
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
          validator: widget.validator,
        ),
      ),
    );
  }
}
