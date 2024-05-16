//floating action button
import 'package:flutter/material.dart';

import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';

// ignore: must_be_immutable
class AddButton extends StatelessWidget {
  VoidCallback? onpressed;
   AddButton({super.key,  this.onpressed,  });

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
  onPressed:onpressed ,
  backgroundColor:DarkPurple,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),

  child:  Icon(Icons.add,color: white,),
 
);
  }
}
