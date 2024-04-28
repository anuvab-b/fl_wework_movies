import 'package:flutter/cupertino.dart';

class CommonText extends StatelessWidget {
  final String title;
  final int maxLines;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const CommonText(
      {super.key,
      required this.title,
      this.fontWeight = FontWeight.w500,
      this.fontSize = 14.0,
      this.maxLines = 1,
      this.color = const Color(0xFF282933)});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: "Poppins",
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color),
    );
  }
}
