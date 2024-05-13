import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/habbits_page/habbit_home.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/popupmenu.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/eddit_habbit.dart';
import 'package:tickyfy/model/database/habbit_db_fnctions.dart';
import 'package:tickyfy/model/model_class/habit_model.dart';

class HabbitTile extends StatefulWidget {
  final String habbitName;
  final HabitModel habit;
  final String days;
  final int checkedDaysCount;

  final VoidCallback onTap;

  const HabbitTile({
    super.key,
    required this.checkedDaysCount,
    required this.days,
    required this.habbitName,
    required this.habit,
    required this.onTap,

    String? habbitQuestion,
  });

  @override
  State<HabbitTile> createState() => _HabbitTileState();
}

class _HabbitTileState extends State<HabbitTile> {
  final TextEditingController habbitNameController = TextEditingController();

  final TextEditingController questionController = TextEditingController();
  List<DateTime> dateList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Text container
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 3),
              //habbit tile on tap bottom sheet
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(19),
                                color: DarkPurple),
                            height: 150,
                            width: 386,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        //we have to change 
                                          text: widget.checkedDaysCount.toString(),
                                          color: white,
                                          fontSize: 40),
                                      CustomText(
                                          text: 'days',
                                          color: white,
                                          fontSize: 40),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CustomText(
                                      text: 'Your current streak',
                                      color: white,
                                      fontSize: 13),
                                ),
                                const SizedBox(width: 15),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 29,
                                        color: white,
                                      ),
                                      const SizedBox(width: 10),
                                      Row(
                                        children: [
                                          CustomText(
                                             //we have to change 
                                              text:widget.checkedDaysCount.toString() ,
                                              color: white,
                                              fontSize: 15),
                                                 CustomText(
                                              text: 'days',
                                              color: white,
                                              fontSize: 15),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CustomText(
                                      text: 'Your longest streak',
                                      color: white,
                                      fontSize: 13),
                                ),
                              ],
                            ));
                      },
                      backgroundColor: DarkPurple);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: DarkPurple, //color
                      borderRadius: BorderRadius.circular(5)),
                  height: 36,
                  width: 151,
                  child: SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 6),
                      child: Row(
                        children: [
                          Text(
                            widget.habbitName,
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 17,
                              color: white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          CustomPopUpButton(items: [
                            MenuItem(
                                icon: Icons.edit,
                                title: 'Edit',
                                onTap: () async {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return NotificationListener(
                                        child: Column(
                                          children: [
                                            EditHabbitBottomSheet(
                                              controller1: questionController,
                                              controller: habbitNameController,
                                              onpressed: () async {
                                                if (habbitNameController
                                                    .text.isEmpty) {
                                                } else {
                                                  HabitModel updatedHabit =
                                                      HabitModel(
                                                    habbitName:
                                                        habbitNameController
                                                            .text,
                                                    habbitQuestion:
                                                        questionController.text,
                                                    // keep the existing habbitCompleted and remainder
                                                    habbitCompleted: widget
                                                        .habit.habbitCompleted,
                                                  
                                                  );

                                                  // Use the updatedHabit instance for the update
                                                  await HabitDBFunctions()
                                                      .editHabbit(
                                                          widget.habit.key,
                                                          updatedHabit);
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomePage()));
                                                }
                                              },
                                              habbit: widget.habit,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }),
                            MenuItem(
                                icon: Icons.delete,
                                title: 'Delete',
                                onTap: () async {
                                  HabitDBFunctions ab = HabitDBFunctions();
                                  await ab
                                      .deleteHabbit(widget.habit.key.toString())
                                      .then(
                                        (value) => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        ),
                                      );
                                })
                          ], color: white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
