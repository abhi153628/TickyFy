import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';

// ignore: must_be_immutable
class AddTaskSheet extends StatefulWidget {
  VoidCallback? onpressed;
  TextEditingController? controller;

  IconData icon;
  Color? color;
  String text2;
  ValueNotifier text3;
  VoidCallback? onTap;
  VoidCallback? onTap2;
  VoidCallback onpressed2;
  final bool condition;

  AddTaskSheet(
      {super.key,
      this.controller,
      this.onpressed,
      required this.condition,
      required this.text2,
      required this.text3,
      required this.icon,
      this.color,
      this.onTap,
      this.onTap2,
      required this.onpressed2});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  // animation when mic is pressed
  bool _micPressed = false;
    // validation  taskname
String? validateMaxLength(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please type the task name!';
  } else if (value.trim().isEmpty) {
    return 'Task name cannot be empty spaces!';
  } else if (value.length > 20) {
    return 'Task name cannot exceed 20 characters!';
  } else if (value.contains(RegExp(r'[0-9]')) ||
      value.contains(RegExp(r'[!@#$%^&*(),?.":{}|<>]'))) {
    return 'Task name cannot contain numbers or symbols!';
  }
  return null;
}
//animation when mic pressed
void toggleAnimation() {
    setState(() {
      _micPressed = !_micPressed;
    });
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: ListTile(
          title: Column(
            children: [
              const Text(
                'Add Voice',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [const SizedBox(width: 12,),
                  CustomText(text: 'Voice Title', color: black, fontSize: 12),
                ],
              ),
              //!task field
              TextFormField(
                 style: TextStyle(color: white),
                controller: widget.controller,
                validator:validateMaxLength,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
               
                  hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: white),
                  filled: true,
                  fillColor: DarkPurple,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                   borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                   
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                 borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                   
                  ),
                
                  hintText: 'e.g Starting to do journal',
                ),
              
              ),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    child: Lottie.asset(
                      'lib/animated_assets/Animation - 1707054868466 (1).json',
                    ),
                  ),
                  const SizedBox(width: 17),
                  CustomText(
                      text: 'Try TickyFy Transcriber !',
                      color: DarkPurple,
                      fontSize: 20),
                ],
              ),
        
              //! This is the speech to text conversion text
              ValueListenableBuilder(
                  valueListenable: widget.text3,
                  builder: (context, text, _) {
                    return Center(
                        child:
                            CustomText(text: text, color: black, fontSize: 20));
                  }),
              // Condition to be passed
              if (widget.condition) const SizedBox(height: 80),
              CustomText(
                  text: "'Tap the mic to talk'", color: DarkPurple, fontSize: 15),
        
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: FloatingActionButton(
                  onPressed: () {
                    toggleAnimation(); // Toggle the animation
                    widget.onpressed2(); // Call the onPressed callback
                  },
                  tooltip: 'Listen',
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                              colors: [DarkPurple, black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)
                          .createShader(bounds);
                    },
                    child: Icon(
                      widget.icon,
                      color: white,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 1,
                ),
                // Text for confidence level
                child: Text(
                  widget.text2,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 228),
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()&&widget.controller!.text.trim().isNotEmpty) {
                        widget.onpressed!();
                      }
                    },
                    child: CustomText(text: 'Save Words', color: DarkPurple, fontSize: 15)),
              ),
              _micPressed
                  ? SizedBox(
                      height: 50,
                      child: Lottie.asset(
                        'lib/animated_assets/Animation - 1715665057745.json',
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
