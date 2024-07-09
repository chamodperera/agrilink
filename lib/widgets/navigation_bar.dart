import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class BottomMenu extends StatefulWidget {
  final ValueChanged<int> onItemSelected;
  final int selectedIndex;

  const BottomMenu({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0), // Adjust the padding as needed
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 15.0),
          color: theme.bottomNavigationBarTheme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                  icon: FluentIcons.home_32_filled, label: 'Home', index: 0),
              _buildNavItem(
                  icon: FluentIcons.broad_activity_feed_24_filled,
                  label: 'Services',
                  index: 1),
              _buildNavItem(
                  icon: FluentIcons.data_bar_vertical_32_filled,
                  label: 'Dashboard',
                  index: 2),
              _buildNavItem(
                  icon: FluentIcons.person_32_filled,
                  label: 'Profile',
                  index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = widget.selectedIndex == index;
    final theme = Theme.of(context);
    final iconTheme = isSelected
        ? theme.bottomNavigationBarTheme.selectedIconTheme
        : theme.bottomNavigationBarTheme.unselectedIconTheme;
    return GestureDetector(
      onTap: () => widget.onItemSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.bottomNavigationBarTheme.selectedItemColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconTheme?.color,
              size: iconTheme?.size,
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  label,
                  style: theme.bottomNavigationBarTheme.selectedLabelStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
