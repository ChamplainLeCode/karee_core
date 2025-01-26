import '../../../utils/style.dart';
import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {
  final double width, height;
  final Color color;
  final String label;
  final double fontSize;

  const BadgeCard(
      {super.key,
      this.width = 24,
      this.height = 15,
      required this.color,
      required this.label,
      required this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Text(label,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: Style.whiteText)),
    );
  }
}
