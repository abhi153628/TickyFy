import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';

class AddTaskSheet extends StatefulWidget {
  VoidCallback? onpressed;
  TextEditingController? controller;


  IconData icon;

  Color? color;

  String text2;
  String text3;

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
bool _micPressed  = false;

void togleAnimation(){
  setState(() {
    
    _micPressed =! _micPressed;
  });
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
                controller: widget.controller,
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
                      child: Lottie.asset('lib/animated_assets/Animation - 1707054868466 (1).json',)),
                  CustomText(
                      text: 'Try TickyFy Transcriber !',
                      color: DarkPurple,
                      fontSize: 20),
                     
                ],
                
              ),
               
                   
          
              //!this is the speech to text convertion text
              Center(child: CustomText(text: widget.text3, color: black, fontSize: 20)),
              //condition to be passed
              if (widget.condition) const SizedBox(height: 80),
                  CustomText(
                      text: "'Tap the mic to talk'",
                      color: DarkPurple,
                      fontSize: 15),
          
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: FloatingActionButton(
                  onPressed: widget.onpressed2,
                  tooltip: 'Listen',
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: ShaderMask(shaderCallback: (Rect bounds){
                    return LinearGradient(colors: [DarkPurple,black],begin: Alignment.topCenter,end: Alignment.bottomCenter).createShader(bounds);
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 228),
                child: ElevatedButton(onPressed: widget.onpressed, child:Text("save Words")),
              )
              
            ],
          ),
        
        
      ),
    );
  }
}
