import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? errorMessage;
  final TextInputType? keyboardType;
  final int minLines;
  final int maxLines;
  final bool autoExpand; // New property to auto-adjust size

  const TextInputField({
    super.key,
    required this.hintText,
    this.validator,
    this.controller,
    this.errorMessage,
    this.keyboardType,
    this.minLines = 1, // Default to a single line
    this.maxLines = 1, // Default to a single line, adjust for multi-line input
    this.autoExpand = false, // By default, auto-expand is off
  });

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInputField> {
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
      width: MediaQuery.of(context).size.width ,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: theme.colorScheme.onBackground,
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        child: TextFormField(
          controller: _controller,
          keyboardType: widget.keyboardType,
          minLines: widget.autoExpand ? null : widget.minLines, // Adjust min lines if auto-expand is enabled
          maxLines: widget.autoExpand ? null : widget.maxLines, // Adjust max lines if auto-expand is enabled
          expands: widget.autoExpand, // Expand based on content
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
            errorText: widget.errorMessage
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
