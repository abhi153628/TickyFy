import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/habbits_page/habbit_home.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/popupmenu.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/eddit_habbit.dart';
import 'package:tickyfy/model/database/habbit_db_fnctions.dart';
import 'package:tickyfy/model/model_class/habit_model.dart';

class HabbitTile extends StatefulWidget {
  final String habbitName;
  final HabitModel habit;

  final VoidCallback onTap;

  const HabbitTile({
    super.key,
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
  bool _isChecked = false;
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
              child: Container(
                decoration: BoxDecoration(
                  color: DarkPurple, //color
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
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
                        ),Spacer(),
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
                                  if (habbitNameController.text.isEmpty) {
                                  } else {
                                    HabitModel updatedHabit = HabitModel(
                                      habbitName: habbitNameController.text,
                                      habbitQuestion: questionController.text,
                                      // keep the existing habbitCompleted and remainder
                                      habbitCompleted:
                                          widget.habit.habbitCompleted,
                                      remainder: widget.habit.remainder,
                                    );

                                    // Use the updatedHabit instance for the update
                                    await HabitDBFunctions().editHabbit(
                                        widget.habit.key, updatedHabit);
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
                    await ab.deleteHabbit(widget.habit.key.toString()).then(
                          (value) => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
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

            
          ],
        ),
      ],
    );
  }

  getDates(DateTime startDate) {
    for (DateTime date = startDate;
        date.isBefore(DateTime.now());
        date = date.add(const Duration(days: 1))) {
      dateList.add(date);
    }
  }
}
