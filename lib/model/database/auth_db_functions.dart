import 'package:hive_flutter/hive_flutter.dart';
import 'package:tickyfy/model/model_class/user_model.dart';


//adding profile name and profile image function 'addProfile'
Future addProfile(String image, String name) async {
  final Box<User> box = await Hive.openBox<User>('users');
  if(box.length==0)
  {
    User user=User(username: name, image: image,password: '');
    await box.add(user);
  }
 else
 {
  var user=box.values.first;
  user.image = image;
  user.name = name;
  await box.put(0, user);
 }
 await box.close();
}
Future <bool> isLogin()async{
   final  box = await Hive.openBox<User>('users');
   return box.isNotEmpty;

}

//getting the user function
Future<User> getUser() async {
  Box<User> box = await Hive.openBox<User>('users');
  print(box.length);
  User user = box.values.first;
  print(user.image);
  await box.close();
  return user;
}




