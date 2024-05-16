// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:tickyfy/Views/auth_pages/onboarding_page.dart';
import 'package:tickyfy/Views/habbits_page/habbit_home.dart';
import 'package:tickyfy/model/database/habbit_db_fnctions.dart';
import 'package:tickyfy/model/database/task_db.dart';
import 'package:tickyfy/model/model_class/user_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
  DecisionWhereToGo();

    intialiseTaskData();
    intialiseShowData();
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 750),
    );
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        setState(() {});
      }
    }
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
            "lib/animated_assets/Animation - 1707054868466 (1).json",
            controller: _controller, onLoaded: (comp) {
          _controller.duration = comp.duration;
          _controller.forward();
        }),
      ),
    );
  }







  intialiseShowData() async {
    HabitDBFunctions abi = HabitDBFunctions();
    await abi.getHabbit();
  }

  intialiseTaskData() async {
    TaskDbFunctions abi = TaskDbFunctions();
    await abi.getTask();
  }

  // ignore: non_constant_identifier_names
  Future<void> DecisionWhereToGo() async {
  await Future.delayed(const Duration(seconds: 2));

  bool checkLogin = await isLogin();


  if (checkLogin) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  } else {

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OnBoardingPage()));
  }
}

Future<bool> isLogin() async {
  final box = await Hive.openBox<User>('users');
  return box.isNotEmpty; // Check if box is not empty for logged in users
}

}
