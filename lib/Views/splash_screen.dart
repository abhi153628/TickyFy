import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tickyfy/Database/db_functions.dart';
import 'package:tickyfy/Views/home_page.dart';
import 'package:tickyfy/database/habbit_db_fnctions.dart';

import 'package:tickyfy/views/onboarding_page.dart';

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
    gotoNextPage();
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
    });
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

  goToWelcome(context) async {
    await Future.delayed(const Duration(milliseconds: 5200));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => OnBoardingPage(),
      ),
    );
  }

  goToHome(context) async {
    await Future.delayed(const Duration(milliseconds: 3600));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomePage(),
      ),
    );
  }

  gotoNextPage() async {
    bool? check = await CheckLogin();
    if (check == true) {
      goToHome(context);
    } else {
      goToWelcome(context);
    }
  }

  intialiseShowData() async {
    HabitDBFunctions abi = HabitDBFunctions();
    await abi.getHabbit();
  }
}
