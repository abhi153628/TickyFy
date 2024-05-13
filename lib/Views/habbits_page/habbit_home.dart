import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tickyfy/Views/habbits_page/habbit_showpage.dart';
import 'package:tickyfy/Views/task_screens/localnotifi.dart';
import 'package:tickyfy/Views/task_screens/task_home.dart';
import 'package:tickyfy/controllers/custom_widgets/snackbar.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/add_habbit.dart';
import 'package:tickyfy/controllers/custom_widgets/animationbutton.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/checkbox.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/fab_button.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/habbit_tile.dart'; 
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/model/database/habbit_db_fnctions.dart';
import 'package:tickyfy/model/model_class/habit_model.dart';
import '../../controllers/helper_widgets/bottom_sheet.dart';
import '../../controllers/custom_widgets/drawermenu.dart';

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
  void scheduleNotification() {
    LocalNotificationService.showDailyScheduledNotification(
      time: const TimeOfDay(hour: 8, minute: 0),
      question: questionController.text,
    );
  }

  Map<String, int> checkedDaysCountMap = {};

//list of dates
  List<DateTime> dateList = [];
  @override
  void initState() {
    super.initState();
    getdates(DateTime.now().subtract(const Duration(days: 30)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePageColor,
      appBar: AppBar(
        backgroundColor: homePageColor,
        title: const Text('Hey User'),
      ),
      body: habbitNotifierList.value.isNotEmpty
          ? ValueListenableBuilder(
              valueListenable: habbitNotifierList,
              builder: (BuildContext context, List<HabitModel> value,
                  Widget? child) {
                return Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 37),
                        child: ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (BuildContext context, int index) {
                              final habit = value[index];
                              final checkedDaysCount =
                                  checkedDaysCountMap[habit.habbitName] ?? 0;
                              return HabbitTile(
                                habbitQuestion: value[index].habbitQuestion,
                                habbitName: value[index].habbitName,
                                onTap: () {
                                  Navigator.of(context).push(
                                    CustomPageRoute(
                                      child:
                                          HabbitShowPage(habit: value[index]),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HabbitShowPage(
                                              habit: habit,
                                            ),
                                          ),
                                        );
                                      },
                                      //passing the count to habbit tile
                                      checkedDaysCount: checkedDaysCount,
                                    ),
                                  );
                                },
                                habit: value[index],
                                days: '',
                                checkedDaysCount: checkedDaysCount,
                              );
                            }),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dateList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(DateFormat('E').format(dateList[index])),
                                Text('${dateList[index].day}'),
                                ...value.map((e) => CheckBox(
                                      initialValue:
                                          e.habbitCompleted?[dateList[index]] ??
                                              false,
                                      onChanged: (isChecked) {
                                        HabitDBFunctions().updateCompletion(
                                            dateList[index],
                                            isChecked ?? false,
                                            e.habbitName);
                                      },
                                      ontapped: (count,ischecked) {
                                        updateCheckedDaysCount(e.habbitName,ischecked);
                                        setState(() {});
                                      },
                                      habitname: '',
                                    )),
                                if (index != dateList.length - 1)
                                  const Divider(),
                              ],
                            );
                          }),
                    ),
                  ],
                );
              },
            )
          : Center(
              child: SizedBox(
                height: 200,
                child: Lottie.asset(
                  "lib/animated_assets/Animation - 1715260002815.json",
                ),
              ),
            ),
      floatingActionButton: AddButton(
        onpressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: CustomBottomSheet(
                  content: ListView(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/assets/images/question (1).png'),
                        ),
                        title: CustomText(
                            text: 'Habbit', color: black, fontSize: 15),
                        subtitle: const Text(
                            'Track your mind using asking question to yourself'),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomBottomSheet(
                                content: Column(
                                  children: [
                                    AddHabbitBottomSheet(
                                      controller1: questionController,
                                      controller: habbitNameController,
                                      onpressed: () async {
                                        if (habbitNameController.text.isEmpty) {
                                        } else {
                                          if (habbitNotifierList.value.length <
                                              3) {
                                            await HabitDBFunctions()
                                                .addHabbit(
                                                    HabitModel(
                                                        habbitName:
                                                            habbitNameController
                                                                .text,
                                                        habbitQuestion:
                                                            questionController
                                                                .text,
                                                        habbitCompleted: null));
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage()));
                                          } else {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            showSnackbar(
                                                context,
                                                'you reached the maximum habits',
                                                red);
                                          }
                                        }
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/assets/images/brain-power.png'),
                        ),
                        title: CustomText(
                            text: 'Voice Notes', color: black, fontSize: 15),
                        subtitle: const Text(
                            'Adding voice notes to remember things for later'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TaskHomePage()));
                        },
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
      //drawer
      drawer: const CustomDrawer(),
    );
  }

  //method to update the count of checked days for each habit
  void updateCheckedDaysCount(String habitname,bool isChecked) async{
    print('sd88888888888888888888s');
    HabitModel? habit = await Hive.box<HabitModel>('habbitbox').get(habitname);
  if(habit!= null){
    if(isChecked){
   habit.checkedDaysCount = (habit.checkedDaysCount ?? 0) + 1;
    }else{
      habit.checkedDaysCount = (habit.checkedDaysCount ?? 0) -1;
    }
    await habit.save();
    
  }
   

    await habit?.save(); 
    
    setState(() {});
  }

  void loadCheckedDaysCount() async {
    Box<HabitModel> habitsBox = await Hive.openBox<HabitModel>('habits');
  
    for (String habitName in habbitNotifierList.value.map((e) => e.habbitName)) {
      HabitModel habit = habitsBox.get(habitName)!;
      checkedDaysCountMap[habitName] = habit.checkedDaysCount!;
    }
  
    setState(() {});
  }

  getdates(DateTime startDate) {
    for (DateTime date = DateTime.now();
        date.isAfter(startDate);
        date = date.subtract(const Duration(days: 1))) {
      dateList.add(DateTime(date.year, date.month, date.day, 0, 0, 0));
    }
  }
}
