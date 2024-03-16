import 'package:flutter/material.dart';
import 'package:tickyfy/Views/home_page.dart';
import 'package:tickyfy/controllers/color_controller.dart';
import 'package:tickyfy/database/habbit_db_fnctions.dart';
import 'package:tickyfy/model/habit_model.dart';

// ignore: must_be_immutable
class HabbitShowPage extends StatelessWidget {
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
               
              },
              icon: const Icon(Icons.edit_outlined)),
          const SizedBox(),
          IconButton(
              onPressed: () async{
                 HabitDBFunctions ab = HabitDBFunctions();
                await ab.deleteHabbit(habit!.key).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage())));
                
              }, icon: const Icon(Icons.delete_outline_outlined))
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: habbitNotifierList,
            builder: (BuildContext context, value, Widget? child) {
              return Text(habit?.habbitName ?? '');
            },
          ),
        ],
      ),
    );
  }
}
