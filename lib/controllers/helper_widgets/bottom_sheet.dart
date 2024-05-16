// import 'package:flutter/material.dart';
// import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';


// class CustomBottomSheet extends StatelessWidget {
//   final Widget content;
//   final double? height;

//   // ignore: prefer_const_constructors_in_immutables
//   CustomBottomSheet({super.key, required this.content, this.height});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus(); // Dismiss keyboard
//       },

//   // that design for the container
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               LightPurple,
//               const Color.fromARGB(255, 93, 59, 219),
//             ],
//           ),
//         ),
//         height: height,
//         child: Center(
//           child: content,
//         ),
//       ),
//     );
//   }
// }
