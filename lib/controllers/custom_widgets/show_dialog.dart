import 'package:flutter/material.dart';

class ShowDialogueBox extends StatelessWidget {
  final String? title;
  final String? content;

  ShowDialogueBox({Key? key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? ''),
      content: Text(content ?? ''),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      backgroundColor: Colors.white,
    );
  }
}
