import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tickyfy/model/model_class/task_model.dart';

ValueNotifier<List<TaskModel>> taskNotifierList = ValueNotifier([]);

class TaskDbFunctions extends ChangeNotifier {
  //adding task
  Future addTask(TaskModel task) async {

    final Box<TaskModel> box = await Hive.openBox('TaskBox');
    await box.add(task);
    await getTask();
    await box.close();
  }

  //Displaying the task
  Future getTask() async {
    final Box<TaskModel> box = await Hive.openBox('TaskBox');
    taskNotifierList.value.clear();
    taskNotifierList.value.addAll(box.values);

    taskNotifierList.notifyListeners();
    await box.close();
  }

  Future deleteTask(int key) async {
    final Box<TaskModel> box = await Hive.openBox('TaskBox');
    await box.delete(key);
    await box.close();
    await getTask();
  }

  //editimg task
  Future editTask(
    int key,
    TaskModel task,
  ) async {
    final Box<TaskModel> box = await Hive.openBox('TaskBox');
    await box.put(key, task);
    await box.close();
    getTask();
  }
}
