import 'package:flutter/material.dart';
import 'package:tickyfy/Views/habbits_page/habbit_home.dart';

import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/eddit_habbit.dart';
import 'package:tickyfy/controllers/helper_widgets/bottom_sheet.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/model/database/habbit_db_fnctions.dart';

import 'package:tickyfy/model/model_class/habit_model.dart';

// ignore: must_be_immutable
class HabbitShowPage extends StatefulWidget {
  final HabitModel habit;

  HabbitShowPage({
    super.key,
    required this.habit,
  });

  @override
  State<HabbitShowPage> createState() => _HabbitShowPageState();
}

class _HabbitShowPageState extends State<HabbitShowPage> {
  final TextEditingController habbitNameController = TextEditingController();

  final TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePageColor,
      appBar: AppBar(
        backgroundColor: homePageColor,
        actions: [
          //edit button
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return NotificationListener(
                    child: 
                       Column(
                        children: [
                          EditHabbitBottomSheet(
                            controller1: questionController,
                            controller: habbitNameController,
                            onpressed: () async {
                              if (habbitNameController.text.isEmpty) {
                              } else {
                               
                                HabitModel updatedHabit = HabitModel(
                                  habbitName: habbitNameController.text,
                                  habbitQuestion: questionController.text,
                                  // keep the existing habbitCompleted and remainder
                                  habbitCompleted: widget.habit.habbitCompleted,
                                  remainder: widget.habit.remainder,
                                );

                                // Use the updatedHabit instance for the update
                                await HabitDBFunctions()
                                    .editHabbit(widget.habit.key, updatedHabit);
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                              }
                            },
                            habbit: widget.habit,
                          )
                        ],
                      ),
                    
                    
                  );
                },
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          const SizedBox(),
          IconButton(
            onPressed: () async {
              HabitDBFunctions ab = HabitDBFunctions();
              await ab.deleteHabbit(widget.habit.key.toString()).then(
                    (value) => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.delete_outline_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: const Color.fromARGB(255, 238, 238, 238)),
            height: 100,
            width: 800,
            child: ValueListenableBuilder(
                valueListenable: habbitNotifierList,
                builder: (BuildContext context, value, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 10),
                        child: CustomText(
                          text: widget.habit.habbitName,
                          color: DarkPurple,
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24, left: 10),
                        child: CustomText(
                            text: widget.habit.habbitQuestion ?? '',
                            color: DarkPurple,
                            fontSize: 16),
                      ),
                    ],
                  );
                }),
          ),
          
         
        ],
      ),
    );
  }
}
