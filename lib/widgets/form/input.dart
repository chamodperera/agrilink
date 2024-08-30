import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String text;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller; // Optional controller

  const TextBox({
    super.key,
    required this.text,
    this.isPassword = false,
    this.validator,
    this.controller, // Optional controller in constructor
  });

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  bool _obscureText = true;
  late TextEditingController
      _controller; // Declare late to initialize in initState
  String? _errorText;

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create a new one
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Only dispose the controller if it was created internally
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
        child: TextField(
          controller: _controller, // Use the controller (internal or external)
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
            errorText: _errorText, // Display error text
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
          onChanged: (value) {
            if (widget.validator != null) {
              setState(() {
                _errorText = widget.validator!(value);
              });
            }
          },
        ),
      ),
    );
  }
}
