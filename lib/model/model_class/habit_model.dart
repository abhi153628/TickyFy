import 'package:hive_flutter/hive_flutter.dart';
part 'habit_model.g.dart';

@HiveType(typeId: 1)
class HabitModel extends HiveObject {
  @HiveField(0)
  String habbitName;
@HiveField(1)
  String? habbitQuestion;
@HiveField(2)
  //?storing checkbox in map a specific date and checkbox value
 late Map<DateTime, bool>? habbitCompleted; 
 @HiveField(3)
   int? checkedDaysCount;
 HabitModel({
    required this.habbitName,
    this.habbitQuestion,
     Map<DateTime, bool>? habbitCompleted, 
     this.checkedDaysCount=0
}): 
  //?creating a empty map 
   habbitCompleted =  habbitCompleted?? {};
}
