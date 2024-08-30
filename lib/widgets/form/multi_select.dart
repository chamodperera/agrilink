import 'package:flutter/material.dart';

class MultiSelectWidget extends StatefulWidget {
  final List<String> items; // List of items to display
  final ValueChanged<List<String>>
      onSelectionChanged; // Callback for when selection changes

  const MultiSelectWidget({
    Key? key,
    required this.items,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _MultiSelectWidgetState createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  List<String> _selectedItems = []; // List to store selected items

  void _onItemCheckedChange(String item, bool isChecked) {
    setState(() {
      if (isChecked) {
        _selectedItems.add(item);
      } else {
        _selectedItems.remove(item);
      }
      widget.onSelectionChanged(
          _selectedItems); // Notify parent widget of changes
    });
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
        child: Column(
          children: widget.items.map((String item) {
            return CheckboxListTile(
              side: BorderSide(color: theme.colorScheme.onSecondary),
              shape: RoundedRectangleBorder(
                // Set the checkbox shape to a circle
                borderRadius:
                    BorderRadius.circular(30), // Circular border radius
              ),
              title: Text(item,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  )),
              value: _selectedItems.contains(item),
              onChanged: (bool? isChecked) {
                _onItemCheckedChange(item, isChecked ?? false);
              },
            );
          }).toList(),
        ));
  }
}
