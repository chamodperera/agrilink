import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  const AppSearchBar({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchBarTheme = theme.searchBarTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: searchBarTheme.backgroundColor!.resolve({}),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
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
