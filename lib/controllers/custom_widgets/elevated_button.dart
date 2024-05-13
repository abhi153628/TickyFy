import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatefulWidget {
  String text;
  IconData? icon;
  double? fontSize;
  VoidCallback onpressed;

  CustomElevatedButton({super.key, 
    required this.text,
    required this.onpressed,
    this.icon,
    this.fontSize,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool? validator;

  String? errortext;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onpressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        elevation: 5,
      
        shadowColor: black.withOpacity(0.9),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 90, minHeight: 36),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.login, color: black),
                const SizedBox(width: 20),
                Text(
                  widget.text,
                  style: GoogleFonts.alegreyaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.fontSize,
                      color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
