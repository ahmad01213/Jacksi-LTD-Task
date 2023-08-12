import 'package:flutter/material.dart';



class Texts extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color textColor;
 
  final String fontFamily;
  final TextAlign align;

  const Texts(
      {super.key,
      required this.title,
      required this.textColor,
      required this.fontSize,

      this.align=TextAlign.start,
      required this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: align,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
     
          height: 1.2,
        ));
  }
}
