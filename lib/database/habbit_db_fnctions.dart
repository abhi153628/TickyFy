import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tickyfy/model/habit_model.dart';

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

  Future editHabbit(
    int key,
    HabitModel habbit,
  ) async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');
    await box.put(key, habbit);
    await box.close();
    getHabbit();
  }

  //delete habbit
  Future deleteHabbit(int key) async {
    final Box<HabitModel> box = await Hive.openBox('habbitbox');
    await box.delete(key);
    await box.close();
    await getHabbit();
  }
}
