import 'package:flutter/material.dart';
import 'package:tickyfy/Views/habbit_showpage.dart';
import 'package:tickyfy/controllers/add_habbit.dart';
import 'package:tickyfy/controllers/animationbutton.dart';
import 'package:tickyfy/controllers/color_controller.dart';
import 'package:tickyfy/controllers/eddit_habbit.dart';
import 'package:tickyfy/controllers/fab_button.dart';
import 'package:tickyfy/controllers/habbit_tile.dart';
import 'package:tickyfy/database/habbit_db_fnctions.dart';
import 'package:tickyfy/model/habit_model.dart';
import '../controllers/widgets/bottom_sheet.dart';
import '../controllers/drawermenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController habbitNameController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  List<bool> habbitCompleted = List.generate(30, (index) => false);

  // ignore: non_constant_identifier_names
  List<String> TodayHabbitList = [];
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      habbitCompleted[index] = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Hey User'),
      ),
      
      //!notifying
      body: habbitNotifierList.value.isNotEmpty
          ? ValueListenableBuilder(
              valueListenable: habbitNotifierList,
              builder: (BuildContext context, List<HabitModel> value,
                  Widget? child) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) {
                    //showing the habbits
                    return HabbitTile(
                        habbitName: value[index].habbitName,
                        habbitCompleted: value[index].habbitCompleted,
                        onChanged: (value) {
                          setState(() {
                            ////////////////////////////////
                          });
                        },
                        onpressed1: () async {
                          //delete the habbit
                          HabitDBFunctions abi = HabitDBFunctions();
                          await abi.deleteHabbit(value[index].key);
                        },
                        //edit the habbit
                        onpressed2: () async {
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
                                          if (habbitNameController
                                              .text.isEmpty) {
                                          } else {
                                            //editing
                                            await HabitDBFunctions().editHabbit(
                                                value[index].key,
                                                HabitModel(
                                                    habbitName:
                                                        habbitNameController
                                                            .text,
                                                    habbitQuestion:
                                                        questionController.text,
                                                    habbitCompleted: false));

                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage()));
                                          }
                                        },
                                        habbit: value[index],
                                      )
                                    ],
                                  ),
                                  height: 800,
                                ),
                              );
                            },
                          );
                        },
                        onTap: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                              child: HabbitShowPage(habit: value[index]),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HabbitShowPage()));
                              },
                            ),
                          );
                        });
                  },
                );
              },
            )
          //if there is no habbits added
          : const Center(
              child: Text('Add Habbits'),
            ),
      floatingActionButton: AddButton(
        onpressed: () {
          //for making the first two
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                //custom bottom sheet for that container showing for bottomsheet
                child: CustomBottomSheet(
                  content: ListView(
                    children: [
                      // this tapping for adding habbits
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/assets/images/question (1).png'),
                        ),
                        title: const Text(
                          'Habit',
                          overflow: TextOverflow.fade,
                        ),
                        subtitle: const Text(
                            'Track your mind using asking question to yourself'),
                        onTap: () {
                          //adding habbits on tapp
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              //again we are using the animated container for designing
                              return CustomBottomSheet(
                                content: Column(
                                  children: [
                                    AddHabbitBottomSheet(
                                      //adding habbitname
                                      controller1: questionController,
                                      //adding question
                                      controller: habbitNameController,
                                      onpressed: () async {
                                        if (habbitNameController.text.isEmpty) {
                                        } else {
                                          await HabitDBFunctions().addHabbit(
                                              HabitModel(
                                                  habbitName:
                                                      habbitNameController.text,
                                                  habbitQuestion:
                                                      questionController.text,
                                                  habbitCompleted: null));

                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                        }
                                      },
                                    )
                                  ],
                                ),
                                // height: 500,
                              );
                            },
                          );
                        },
                      ),
                      // pressing  for Atomic habbits --next options
                      const Divider(),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/assets/images/brain-power.png'),
                        ),
                        title: Text('Atomic habits'),
                        subtitle:
                            Text('Stay Motivated when you have no confidence'),
                      ),
                    ],
                  ),
                  height: 250,
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: const CustomDrawer(),
    );
  }
}
