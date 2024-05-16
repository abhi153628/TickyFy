import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tickyfy/Views/auth_pages/about.dart';
import 'package:tickyfy/Views/task_screens/localnotifi.dart';
import 'package:tickyfy/Views/task_screens/task_home.dart';
import 'package:tickyfy/controllers/custom_widgets/snackbar.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/add_habbit.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/checkbox.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/fab_button.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/habbit_tile.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/model/database/habbit_db_fnctions.dart';
import 'package:tickyfy/model/model_class/habit_model.dart';
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
  //notification
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), 
        child: ClipRRect(
          borderRadius: const BorderRadius.only(  bottomLeft: Radius.circular(30), 
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30)),
          child: AppBar(
            backgroundColor: DarkPurple, 
            elevation: 0, 
            title: const Text(
              'Track Your Habits',
              style: TextStyle(
                fontSize: 22, // Customize font size
                fontWeight: FontWeight.bold, // Customize font weight
                color: Colors.white, // Customize text color
              ),
            ),
            
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.info_outline_rounded,color: white,),
                onPressed: () {
                  Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                       const AboutPage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                  
                },
              ),
            
            ],
          ),
        ),
      ),
      body: habbitNotifierList.value.isNotEmpty
          ? SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height*(habbitNotifierList.value.length/19),
              width: MediaQuery.of(context).size.width,
              child: ValueListenableBuilder(
                  valueListenable: habbitNotifierList,
                  builder: (BuildContext context, List<HabitModel> value,
                      Widget? child) {
                    return Row(
                      children: [
                        
                        SizedBox(
                          width: 160,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 34),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final habit = value[index];
                                  
                                  final checkedDaysCount =
                                      habit.checkedDaysCount;
                                  //habbit tile
                                  return HabbitTile(
                                    habbitQuestion: value[index].habbitQuestion,
                                    habbitName: value[index].habbitName,
                                    habit: value[index],
                                    days: '',
                                    checkedDaysCount: checkedDaysCount??0,
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            // height: MediaQuery.of(context).size.height*2,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dateList.length,
                                itemBuilder: (BuildContext context, int index) {
                                 
                                  return SizedBox(
                                    width:   MediaQuery.of(context).size.width*0.129,
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView(
                                      physics:const NeverScrollableScrollPhysics(),
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(child: Text(DateFormat('E').format(dateList[index]))),
                                        Center(child: Text('${dateList[index].day}')),
                                        ...value.map((e) {
                                                          
                                          return CheckBox(
                                              initialValue: e.habbitCompleted?[
                                                      dateList[index]] ??
                                                  false,
                                              onChanged: (isChecked) {
                                                HabitDBFunctions().updateCompletion(
                                                    dateList[index],
                                                    isChecked ?? false,
                                                    e.habbitName);
                                              },
                                              ontapped: (count, ischecked) async{
                                              e.checkedDaysCount= await updateCheckedDaysCount(
                                                    e, ischecked);
                                                setState(() {});
                                              },
                                              habitname: '',
                                            );
                                                                    }),
                                        if (index != dateList.length - 1)
                                          const Divider(),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    );
                  },
                ),
            ),
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
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [white, LightPurple]),
                  ),
                  height: MediaQuery.of(context).size.height * 0.23,
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/assets/images/question (1).png'),
                        ),
                        title: CustomText(
                            text: 'Habit Track', color: black, fontSize: 17),
                        subtitle: const Text(
                            'Track your mind using asking question to yourself'),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [white, LightPurple]),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: AddHabbitBottomSheet(
                                          controller1: questionController,
                                          controller: habbitNameController,
                                          onpressed: () async {
                                            if (habbitNameController
                                                .text.isEmpty) {
                                              // Handle empty habit name
                                            } else {
                                             
                                                await HabitDBFunctions()
                                                    .addHabbit(HabitModel(
                                                  habbitName:
                                                      habbitNameController.text,
                                                  habbitQuestion:
                                                      questionController.text,
                                                  habbitCompleted: null,
                                                ));
                                          // ignore: use_build_context_synchronously
                                          showCustomSucessSnackbar(context, "Success", 'Habit added Successfuly',Colors.white);
                                             // ignore: use_build_context_synchronously
                                             Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage(),
                                                  ),
                                                  (route) => false,
                                                );
                                                habbitNameController.text='';
                                                questionController.text='';
                                              
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            // backgroundColor:Color()
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
                            text: 'Voice Notes', color: black, fontSize: 17),
                        subtitle: const Text(
                            'Adding voice notes to remember things for later'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TaskHomePage()));
                        },
                      ),
                    ],
                  ),
                );
              },
              backgroundColor: LightPurple);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //drawer
      drawer: const CustomDrawer(),
    );
  }
//method to update the count of checked days for each habit
  Future<int> updateCheckedDaysCount(HabitModel habit1, bool isChecked) async {
    await Hive.close();
    await Hive.openBox<HabitModel>('habbitbox');
    HabitModel? habit =  Hive.box<HabitModel>('habbitbox').get(habit1.key);
    if (habit != null) {
      if (isChecked) {
        habit.checkedDaysCount = (habit.checkedDaysCount ?? 0) + 1;
      } else {
        habit.checkedDaysCount = (habit.checkedDaysCount ?? 0) - 1;
      }
      // await habit.save();
      
    }

    await habit?.save();
    setState(() {});

    return habit?.checkedDaysCount??0;
  }

  void loadCheckedDaysCount() async {
    Box<HabitModel> habitsBox = await Hive.openBox<HabitModel>('habits');

    for (String habitName
        in habbitNotifierList.value.map((e) => e.habbitName)) {
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
