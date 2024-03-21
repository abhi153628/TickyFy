import 'package:flutter/material.dart';
import 'package:tickyfy/Views/home_page.dart';
import 'package:tickyfy/controllers/color_controller.dart';
import 'package:tickyfy/controllers/eddit_habbit.dart';
import 'package:tickyfy/controllers/widgets/bottom_sheet.dart';
import 'package:tickyfy/controllers/widgets/textstyle.dart';

import 'package:tickyfy/database/habbit_db_fnctions.dart';
import 'package:tickyfy/model/habit_model.dart';

// ignore: must_be_immutable
class HabbitShowPage extends StatelessWidget {
  final TextEditingController habbitNameController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final HabitModel? habit;

  HabbitShowPage({
    Key? key,
    this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                await HabitDBFunctions().editHabbit(
                                  habit?.key,
                                  HabitModel(
                                    habbitName: habbitNameController.text,
                                    habbitQuestion: questionController.text,
                                    habbitCompleted: false,
                                  ),
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              }
                            },
                            habbit: habit!,
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
              await ab.deleteHabbit(habit!.key).then(
                    (value) => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
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
          ValueListenableBuilder(
            valueListenable: habbitNotifierList,
            builder: (BuildContext context, value, Widget? child) {
return Column( 
  children: [
    Padding(
      padding: const EdgeInsets.only(right: 240),
      child: CustomText(text: habit?.habbitName ?? '', color: DarkPurple, fontSize: 12,  ),
    ),SizedBox(height: 20,),
    Row(
      children: [
        SizedBox(width: 20,),
        CustomText(text: habit?.habbitQuestion ?? '', color: DarkPurple, fontSize: 10),
      ],
    )
  ],
);
  }),
        ],
      ),
    );
  }
}
