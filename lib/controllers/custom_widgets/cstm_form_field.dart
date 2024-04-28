import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomFormField extends StatefulWidget {
  String? hintText;
  double? borderRadius;
  String? labeltext;
  IconData? icon;
  bool? validator;
  String errortext;
TextEditingController?  controller;
 CustomFormField(
      {super.key, this.hintText, this.borderRadius, this.labeltext, this.icon,   required this.validator,
      required this.errortext,
      required this.controller});
  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}
class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value){setState(() {
          widget.validator = value.isEmpty;
      });
      },
    decoration: InputDecoration(
        
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.5,
          color: Color.fromARGB(255, 62, 61, 61),
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
        hintText: widget.hintText,
        
        errorText:widget.validator!  ?widget.errortext:null,
        prefixIcon: Icon(widget.icon),
        filled: true,
        
        fillColor: Color.fromARGB(233, 246, 238, 238),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Color.fromARGB(0, 42, 142, 0)),
        ),
       
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}
