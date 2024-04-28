import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  String spokenWords;
  int? tasknumber;

  TaskTile({super.key, required this.taskName, this.spokenWords = '',this.tasknumber});

  List<DateTime> dateList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 5),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16),
                //  child: CustomText(text: '#1', color: black, fontSize: 26),
              ),
              const SizedBox(
                width: 8,
              ),
              //container
              Container(
                decoration:  BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: DarkPurple
                ),
                height: 177,
                width: 355,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Padding(
                      padding: const EdgeInsets.only(left: 1, top: 7),
                      child: Column(
                        children: [
                          const SizedBox(width: 24),
                          Column(
                            children: [
                              //voice number
                            CustomText(text: tasknumber.toString(), color: white, fontSize: 24),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                   taskName,
                                  style:
                                      GoogleFonts.robotoCondensed(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 150),
                                    //wordsspoken
                                child: Text(
                                  spokenWords,
                                  style:
                                      GoogleFonts.robotoCondensed(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
