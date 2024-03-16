//floating action button
import 'package:flutter/material.dart';
import 'package:tickyfy/controllers/color_controller.dart';

// ignore: must_be_immutable
class AddButton extends StatelessWidget {
  VoidCallback? onpressed;
   AddButton({super.key,  this.onpressed,  });

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
  onPressed:onpressed ,
  backgroundColor:LightPurple,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),

  child: const Icon(Icons.add),
 
);
  }
}