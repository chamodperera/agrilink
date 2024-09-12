import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String) onSubmitted;
  final TextEditingController
      controller; // Accept controller from parent widget

  const AppSearchBar({
    Key? key,
    required this.hintText,
    required this.onSubmitted,
    required this.controller, // Add controller as a required parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchBarTheme = theme.searchBarTheme;

    void handleSubmit(String message) {
      onSubmitted(controller.text);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: searchBarTheme.backgroundColor!.resolve({}),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        controller: controller, // Use the provided controller
        onSubmitted: handleSubmit,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: searchBarTheme.hintStyle!.resolve({}),
          prefixIcon:
              const Icon(FluentIcons.search_32_regular, color: Colors.white),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }
}
