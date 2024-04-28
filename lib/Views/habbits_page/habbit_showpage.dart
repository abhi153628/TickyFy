import 'package:flutter/material.dart';
import 'package:tickyfy/Views/habbits_page/habbit_home.dart';

import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/eddit_habbit.dart';
import 'package:tickyfy/controllers/helper_widgets/bottom_sheet.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/model/database/habbit_db_fnctions.dart';

import 'package:tickyfy/model/model_class/habit_model.dart';

// ignore: must_be_immutable
class HabbitShowPage extends StatelessWidget {
  final TextEditingController habbitNameController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final HabitModel habit;

  HabbitShowPage({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePageColor,
      appBar: AppBar(
        backgroundColor: homePageColor,
        actions: [
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return NotificationListener(
                    child: CustomBottomSheet(
                      content: Column(
                        children: [
                          EditHabbitBottomSheet(
                            controller1: questionController,
                            controller: habbitNameController,
                            onpressed: () async {
                              if (habbitNameController.text.isEmpty) {
                              } else {
                                // new instance with updated values
                                HabitModel updatedHabit = HabitModel(
                                  habbitName: habbitNameController.text,
                                  habbitQuestion: questionController.text,
                                  // keep the existing habbitCompleted and remainder
                                  habbitCompleted: habit.habbitCompleted,
                                  remainder: habit.remainder,
                                );

                                // Use the updatedHabit instance for the update
                                await HabitDBFunctions()
                                    .editHabbit(habit.key, updatedHabit);
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                              }
                            },
                            habbit: habit,
                          )
                        ],
                      ),
                      height: 800,
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
              await ab.deleteHabbit(habit.key.toString()).then(
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
                          text: habit.habbitName,
                          color: DarkPurple,
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24, left: 10),
                        child: CustomText(
                            text: habit.habbitQuestion ?? '',
                            color: DarkPurple,
                            fontSize: 16),
                      ),
                    ],
                  );
                }),
          ),
          SizedBox(height: 480),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19), color: DarkPurple),
              height: 150,
              width: 386,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CustomText(text: '0 day', color: white, fontSize: 40),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CustomText(
                        text: 'Your current streak',
                        color: white,
                        fontSize: 13),
                  ),
          SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [ Icon(
                    Icons.star,
                    size: 29,color: white,
                  ),                  SizedBox(width: 10),

                        CustomText(text: '0 day', color: white, fontSize: 15),
                      ],
                    ),
                  ),
               SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CustomText(text: 'Your longest streak', color: white, fontSize: 13),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
