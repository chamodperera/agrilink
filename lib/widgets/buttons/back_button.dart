import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/back.svg', // Replace with your SVG file path
        width: 40, // Adjust the width as needed
        height: 40, // Adjust the height as needed
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
