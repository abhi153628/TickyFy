import 'package:flutter/material.dart';


void showSnackbar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(message),
    // ignore: prefer_const_constructors
    duration: Duration(seconds: 1),
  ));
}
