import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String) onSubmitted;

  const AppSearchBar({Key? key, required this.hintText, required this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchBarTheme = theme.searchBarTheme;
    final TextEditingController textEditingController = TextEditingController();

    void handleSubmit(String message) {
      onSubmitted(textEditingController.text);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: searchBarTheme.backgroundColor!.resolve({}),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        controller: textEditingController,
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
