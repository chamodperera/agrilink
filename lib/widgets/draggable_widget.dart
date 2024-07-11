import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget {
  final List<Widget> children;

  const DraggableWidget({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  width: 60, // Width of the drag indicator
                  height: 5, // Height of the drag indicator
                  decoration: BoxDecoration(
                    color: theme
                        .colorScheme.onSecondary, // Color of the drag indicator
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                ...children,
              ],
            ),
          ),
        );
      },
    );
  }
}
