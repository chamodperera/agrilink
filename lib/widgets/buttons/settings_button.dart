import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final bool isDropdown;
  final Color backgroundColor;
  final List<Widget> expandedItems;
  final double radius;
  final bool lastItem;

  const SettingsButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.iconColor = const Color(0xFF53E88B),
    this.isDropdown = false,
    this.backgroundColor = const Color(0xFF2A2A2A),
    this.expandedItems = const [],
    this.radius = 15,
    this.lastItem = false,
  }) : super(key: key);

  @override
  _SettingsButtonState createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  bool isExpanded = false;

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              widget.onPressed();
              if (widget.isDropdown) {
                _toggleExpand();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.backgroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.radius),
                  topRight: Radius.circular(widget.radius),
                  bottomLeft: Radius.circular(isExpanded ? 0 : widget.lastItem? 15 : widget.radius),
                  bottomRight: Radius.circular(isExpanded ? 0 : widget.lastItem? 15 : widget.radius),
              ),
            ),
          ),
            child: Row(
              children: [
                Icon(widget.icon, color: widget.iconColor),
                const SizedBox(width: 15),
                Text(widget.text,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                    )),
                if (widget.isDropdown) ...[
                  const Spacer(),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: Icon(
                      FluentIcons.chevron_down_20_regular,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (isExpanded) ...widget.expandedItems,
      ],
    );
  }
}
