import 'package:flutter/material.dart';
import 'package:nodes/utilities/constants/colors.dart';

class CustomDot extends StatelessWidget {
  const CustomDot({
    super.key,
    this.padding = 2,
    this.color = BORDER,
  });

  final double padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
