// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  final bool initialValue;
  final Function(bool?)? onChanged;
  final Function(int,bool)? ontapped;
  final String habitname;

  const CheckBox({
    super.key,
    required this.ontapped,
    required this.habitname,
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  late bool _isChecked;
  final int _tapCount = 0; 

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 15),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isChecked = !_isChecked;
            widget.onChanged?.call(_isChecked);
            widget.ontapped?.call(_tapCount,_isChecked);
          });
        },
        child: Row( // Wrap in a Row
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 2,
                ),
                color: _isChecked ? const Color.fromARGB(255, 0, 0, 0) : Colors.transparent,
              ),
              child: _isChecked
                  ? const Icon(
                      Icons.check,
                      size: 20,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: 8), // Add a SizedBox for spacing
            Text(widget.habitname), // Your text
          ],
        ),
      ),
    );
  }
}
