import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  Color color;
  int fontSize;


   CustomText({super.key, required  this.text,required this.color,required this.fontSize,});

  @override
  Widget build(BuildContext context) {
    return Text(
text,
  style: GoogleFonts.aBeeZee(fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: color)
);
  }
}