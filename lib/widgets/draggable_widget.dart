import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget {
  final List<Widget> children;

  /// These sizes can be passed as parameters or defaulted.
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  const DraggableWidget({
    Key? key,
    required this.children,
    this.initialChildSize = 0.6, // Default value: 60% of the screen height
    this.minChildSize = 0.4, // Default value: 40% of the screen height
    this.maxChildSize = 0.8, // Default value: 80% of the screen height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize, // Use the passed or default value
          minChildSize: minChildSize, // Use the passed or default value
          maxChildSize: maxChildSize, // Use the passed or default value
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
                        color: theme.colorScheme
                            .onSecondary, // Color of the drag indicator
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                    ...children,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
