import 'package:flutter/material.dart';
import 'package:tickyfy/Views/task_show_page.dart';
import 'package:tickyfy/controllers/addtask.dart';
import 'package:tickyfy/controllers/animationbutton.dart';
import 'package:tickyfy/controllers/color_controller.dart';

import 'package:tickyfy/controllers/fab_button.dart';
import 'package:tickyfy/controllers/tasktile.dart';
import 'package:tickyfy/controllers/widgets/bottom_sheet.dart';

import 'package:tickyfy/database/task_db.dart';
import 'package:tickyfy/model/task_model.dart';

class TaskHomePage extends StatefulWidget {
  
  final TaskModel? task;
  TaskHomePage({Key? key, this.task}) : super(key: key);

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage>
    with SingleTickerProviderStateMixin {
      @override
  void initState() {
   

    // TODO: implement initState
    super.initState();
  }
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightPurple,
      body: taskNotifierList.value.isNotEmpty
          ? ValueListenableBuilder(
              valueListenable: taskNotifierList,
              builder:
                  (BuildContext context, List<TaskModel> value, Widget? child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:300,
                      child: ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TaskTile(
                              taskName: value[index].taskName,
                              onTap: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    child: TaskShowPage(task: value[index]),
                                    onTap: () {
                                       Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          }
                          ),
                    ),
                    
                    ]);
                  
                }              )
  
          : Center(
              child: Text('Add Voices'),
    ),
    floatingActionButton: AddButton(
                        onpressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext) {
                              return
                              
                                 Padding(
                                   padding: MediaQuery.of(context).viewInsets,
                                   child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: AddTaskSheet(
                                          controller: taskController,
                                          onpressed: () async {
                                            if (taskController.text.isEmpty) {
                                            } else {
                                              await TaskDbFunctions().addTask(
                                                  TaskModel(
                                                      TaskName: taskController.text,
                                                      taskName: ''));
                                              print(
                                                  'aaaaaaaaaaaa');
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TaskHomePage()));
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                                                   ),
                                 );
                              
                            },
                          );
                        },
                      ),);

  }}