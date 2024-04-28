import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? image;

  User({required this.username, required this.password, this.name, this.image});
}
