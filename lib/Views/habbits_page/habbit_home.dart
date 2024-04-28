import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tickyfy/Views/habbits_page/habbit_showpage.dart';
import 'package:tickyfy/Views/task_screens/task_home.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/add_habbit.dart';
import 'package:tickyfy/controllers/custom_widgets/animationbutton.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/checkbox.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/fab_button.dart';
import 'package:tickyfy/controllers/helper_widgets/habbit_helper/habbit_tile.dart'; //home page
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
                              return HabbitTile(habbitQuestion:value[index].habbitQuestion,
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
                                                    HabbitShowPage(habit: value[index],)));
                                      },
                                    ),
                                  );
                                },
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
                                          dateList[index], isChecked ?? false,
                                          e.habbitName);
                                    })),
                                if (index != dateList.length - 1) const Divider(),
                              ],
                            );
                          }),
                    ),
                  
                  ],
                );
              },
            )
          : const Center(
              child: Text('Add habbits'),
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
                        title: CustomText(text: 'Habbit', color: black, fontSize: 15),
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
                                          await HabitDBFunctions().addHabbit(
                                              HabitModel(
                                                  habbitName:
                                                      habbitNameController.text,
                                                  habbitQuestion:
                                                      questionController.text,
                                                  habbitCompleted: null));

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
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
                        title:  CustomText(text: 'Voice Notes', color: black, fontSize: 15),
                        subtitle:
                            const Text('Adding voice notes to remember things for later'),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TaskHomePage()));
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


  getdates(DateTime startDate) {
  for (DateTime date = DateTime.now();
      date.isAfter(startDate);
      date = date.subtract(const Duration(days: 1))) {
    dateList.add(DateTime(date.year, date.month, date.day, 0, 0, 0));
  }
}

}
