import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/constants.dart';

class CMText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final Color color;
  final bool? softWrap;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  const CMText({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.textAlign = TextAlign.start,
    this.color = myTextColorDark,
    this.maxLines,
    this.overflow,
    this.fontWeight = FontWeight.w400,
    this.textScaleFactor,
    this.softWrap = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        softWrap: softWrap,
        style: GoogleFonts.quicksand(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ));
  }
}
