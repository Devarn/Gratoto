import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final FontWeight fontWeight;
  final FontStyle ?fontStyle;
  final double size;
  final Color color;
  final double ?ls;
  final TextAlign ?align;

  const CustomText({super.key, required this.text, required this.size, required this.color, required this.fontFamily, required this.fontWeight, this.fontStyle, this.ls, this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: ls,
      ),
      textAlign: align,
    );
  }
}
