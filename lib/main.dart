import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tickyfy/views/splash_screen.dart';
import 'model/habit_model.dart';
import 'model/user_model.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //directory where the application can store cached data

  //creating database
  await Hive.initFlutter();
  //registering type adapter
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(HabitModelAdapter());
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
