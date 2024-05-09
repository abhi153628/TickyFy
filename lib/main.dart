import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tickyfy/Views/auth_pages/splash_screen.dart';
import 'package:tickyfy/Views/task_screens/localnotifi.dart';

import 'package:tickyfy/model/model_class/task_model.dart';
import 'package:tickyfy/model/model_class/user_model.dart';

import 'model/model_class/habit_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Future.wait<dynamic>([LocalNotificationService.init(),
]);

  
  

  //creating database
  await Hive.initFlutter();
  //registering type adapter
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(HabitModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());

  // await LocalNotificationService.init();
  // await WorkManagerService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black12),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
