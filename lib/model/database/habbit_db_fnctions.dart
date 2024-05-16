import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tickyfy/model/model_class/habit_model.dart';

ValueNotifier<List<HabitModel>> habbitNotifierList = ValueNotifier([]);

class HabitDBFunctions extends ChangeNotifier {
//adding habbit
  Future addHabbit(HabitModel habbitname) async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');
    await box.add(habbitname);
    await getHabbit();
    await box.close();
  }

//getting habbbit
  Future getHabbit() async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');
    habbitNotifierList.value.clear();
    habbitNotifierList.value.addAll(box.values);
    habbitNotifierList.notifyListeners();
    await box.close();
  }
//editing habbit

Future editHabbit(int key, HabitModel updatedHabit) async {
 final Box<HabitModel> box = await Hive.openBox('habbitbox');
 await box.put(key, updatedHabit); // Use the key of the habit you're updating
 await box.close();
 habbitNotifierList.notifyListeners();
 getHabbit();
}



  //delete habbit
  Future deleteHabbit(String key) async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');
    await box.delete(int.parse(key));
    await box.close();
    await getHabbit();
  }

  //?first finds a habbit in the hiveBox and update its completion status for a specific date, and stores the updated habbit
  Future updateCompletion(DateTime date, bool status,String habbitname) async {
    //ignoring the time
    date=DateTime(date.year,date.month,date.day);
    final Box<HabitModel> box = await Hive.openBox('habbitbox');
    
    //?checks that each habbit contains the specific date
    final habit = box.values.firstWhere(
        (element) => element.habbitName==habbitname);
    // ?if found in the Hive box if statement will work
    //?assigns the value of date key to the new status
    habit.habbitCompleted?[date] = status;
    await box.put(habit.key, habit);
      await box.close();
    getHabbit();

//?When a checkbox is tapped, the corresponding `HabitModel` object is updated with the checkbox value for that date. 
//?The updated `HabitModel` object is then stored using `editHabbit` method in `HabitDBFunctions`,
//? ensuring that the checkbox state is saved and displayed correctly when the app is reloaded or restarted.

  }
}
