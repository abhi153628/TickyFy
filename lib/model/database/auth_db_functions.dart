import 'package:hive_flutter/hive_flutter.dart';
import 'package:tickyfy/model/model_class/user_model.dart';

//adding user function 'addUser'
Future addUser(User user) async {
  final Box<User> box = await Hive.openBox<User>('users');
  await box.add(user);
  box.close();
}

//adding profile name and profile image function 'addProfile'
Future addProfile(String? image, String? name) async {
  final Box<User> box = await Hive.openBox<User>('users');
  var user = box.values.first;
  user.image = image;
  user.name = name;
  await box.put(0, user);
  box.close();
}

//getting the user function
Future<User> getUser() async {
  Box<User> box = await Hive.openBox<User>('users');
  User user = box.values.first;
  box.close();
  return user;
}

//Validating a user:
Future<bool> validateUser(String username, String password) async {
  final Box<User> box = await Hive.openBox<User>('users');
  if (username == box.values.first.username &&
      password == box.values.first.password) {
    box.close();
    return true;
  } else {
    box.close();
    return false;
  }
}

//delete your presisitant account
Future<bool> deleteAccount(int key, String password) async {
  final Box<User> box = await Hive.openBox<User>('users');
  final user = box.get(key);
  if (user != null && user.password == password) {
    box.delete(key);
    return true;
  } else {
    return false;
  }
}

//password updating
void changePassword(String password, String newpassword) async {
  final Box<User> box = await Hive.openBox<User>('users');
  box.close();
}
//check whether login or not login

setCheckLogin(bool login) async {
  final Box<bool> box = await Hive.openBox<bool>('login');
  box.put('abhi', login);
  box.close();
}

Future<bool?> CheckLogin() async {
  final Box<bool> box = await Hive.openBox<bool>('users');
  try {
    return box.values.isNotEmpty;
  } finally {
    box.close();
  }
}
