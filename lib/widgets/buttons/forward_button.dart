import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ForwardButtonWidget extends StatelessWidget {
  const ForwardButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      // Border radius for ripple effect
      child: Container(
        decoration: BoxDecoration(
          color: colors.onError,
          borderRadius:
              BorderRadius.circular(30.0), // Border radius for button shape
        ),
        padding: const EdgeInsets.all(8.0), // Padding for the icon
        child: Icon(
          size: 18,
          FluentIcons.ios_arrow_rtl_24_filled,
          color: colors.error,
        ),
      ),
    );
  }
}
