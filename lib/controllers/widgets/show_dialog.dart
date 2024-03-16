import 'package:flutter/material.dart';

class Show_Dialogue_Box extends StatelessWidget {
  String ? tittle;
  String ? content; 

   Show_Dialogue_Box({super.key,this.tittle,this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tittle!),
      content:Text(tittle!) ,

    );
  }
}