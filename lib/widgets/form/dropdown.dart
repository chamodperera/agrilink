import 'package:flutter/material.dart';

class DropdownInput extends StatefulWidget {
  final String hintText;
  final String? errorMessage;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;
  final EdgeInsetsGeometry padding;

  const DropdownInput({
    super.key,
    required this.hintText,
    required this.items,
    this.errorMessage,
    this.selectedItem,
    this.onChanged,
    this.padding = const EdgeInsets.only(left: 15, right: 15, bottom: 5),
  });

  @override
  _DropdownInputFieldState createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInput> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: theme.colorScheme.onBackground,
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedItem,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(6),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.onSecondary,
          ),
          errorText: widget.errorMessage,
        ),
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        dropdownColor: theme.colorScheme.background,
      ),
    );
  }
}
