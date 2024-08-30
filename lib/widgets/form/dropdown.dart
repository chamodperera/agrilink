import 'package:flutter/material.dart';

class DropdownWidget<T> extends StatelessWidget {
  final List<T> items; // List of items to display in the dropdown
  final T? selectedItem; // Currently selected item
  final String Function(T)?
      itemToString; // Function to convert item to string for display
  final ValueChanged<T?>? onChanged; // Callback for when an item is selected
  final String hintText; // Placeholder text when no item is selected

  const DropdownWidget({
    Key? key,
    required this.items,
    required this.selectedItem,
    this.itemToString,
    this.onChanged,
    this.hintText = 'Select an item',
  }) : super(key: key);

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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedItem,
          hint: Text(
            hintText,
            style: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
          isExpanded: true,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemToString != null ? itemToString!(item) : item.toString(),
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: theme.colorScheme.background,
        ),
      ),
    );
  }
}
