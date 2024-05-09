import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/model/model_class/task_model.dart';

// ignore: must_be_immutable
class EditTaskSheet extends StatefulWidget {
  VoidCallback onpressed;

  TaskModel task;
  IconData icon;
  Color? color;
  String text2;
  ValueNotifier text3;
  VoidCallback? onTap;
  VoidCallback? onTap2;
  VoidCallback onpressed2;
  final bool condition;
  final TextEditingController controller;
  EditTaskSheet(
      {super.key,
      required this.controller,
 
     required this.onpressed,
      required this.task,
      required this.condition,
      required this.text2,
      required this.text3,
      required this.icon,
      this.color,
      this.onTap,
      this.onTap2,
      required this.onpressed2});

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  // animation when mic is pressed
  bool _micPressed = false;

  void togleAnimation() {
    setState(() {
      _micPressed = !_micPressed;
    });
  }
//controller
  late TextEditingController controller;
  
  @override
  void initState() {
    controller=widget.controller;
    controller.text = widget.task.taskName;

    

    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListTile(
        title: Column(
          children: [
            const Text(
              'Add Voice',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please give Voice note';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Voice Tittle',
                hintText: 'e.g Starting to do journal',
              ),
            ),
            Row(
              children: [
                SizedBox(
                    height: 45,
                    child: Lottie.asset(
                      'lib/animated_assets/Animation - 1707054868466 (1).json',
                    )),
                CustomText(
                    text: 'Try TickyFy Transcriber !',
                    color: DarkPurple,
                    fontSize: 20),
              ],
            ),

            //!this is the speech to text convertion text
            ValueListenableBuilder(
                valueListenable: widget.text3,
                builder: (context, text, _) {
                  return Center(
                      child:
                          CustomText(text: text, color: black, fontSize: 20));
                }),
            //condition to be passed
            if (widget.condition) const SizedBox(height: 80),
            CustomText(
                text: "'Tap the mic to talk'", color: DarkPurple, fontSize: 15),

            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: FloatingActionButton(
                onPressed: widget.onpressed2,
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
              //text for that confidence:
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
                    widget.task.taskName = controller.text;
                    // widget.task?.spokenWords;
                    widget.onpressed();
                  },
                  child: const Text("edit Words")),
            )
          ],
        ),
      ),
    );
  }
}
