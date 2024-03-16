import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'habit_model.g.dart';

@HiveType(typeId: 1)
class HabitModel extends HiveObject {
  @HiveField(0)
  String habbitName;

  @HiveField(1)
  String? habbitQuestion;

  @HiveField(2)
  bool? habbitCompleted;

  @HiveField(4)
  TimeOfDay? remainder;

  HabitModel({
    required this.habbitName,
    this.habbitQuestion,
    required this.habbitCompleted,
    this.remainder,
  });
}
