import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  Color color;
  double fontSize;


   CustomText({super.key, required  this.text,required this.color,required this.fontSize,});

  @override
  Widget build(BuildContext context) {
    return Text(
text,
  style: GoogleFonts.aBeeZee(fontSize: fontSize,
  
    fontWeight: FontWeight.w900,
    color: color)
);
  }
}