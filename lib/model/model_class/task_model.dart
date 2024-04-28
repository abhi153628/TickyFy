import 'package:hive_flutter/hive_flutter.dart';
part 'task_model.g.dart';
@HiveType(typeId: 2)
class TaskModel extends HiveObject{
  @HiveField(0)
  String taskName;
  @HiveField(1)
  String spokenWords;
  @HiveField(2)
   late String ?filePath;
   @HiveField(3)
     late DateTime? date;
     TaskModel({required  this.taskName,this.filePath,this.date,required this.spokenWords});

}
