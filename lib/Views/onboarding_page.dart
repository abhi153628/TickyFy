import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';

import 'package:tickyfy/Views/welcome_page.dart';

class OnBoardingPage extends StatelessWidget {

  final List<Introduction> list = [
    Introduction(
      imageUrl: 'lib/assets/images/pixeltrue-meditation-1.png',
      imageHeight: 410,
      title: "Stay Motivated",
      titleTextStyle: GoogleFonts.nunito(
          fontSize: 29,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0)),
      subTitle:
          'Create Streaks of your habbits and complete all your tasks.',
      subTitleTextStyle: GoogleFonts.dekko(
          fontSize: 21,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          color: const Color.fromARGB(255, 255, 255, 255)),
    ), //2onboarding
    Introduction(
        imageUrl: 'lib/assets/images/8698793_3958832-removebg-preview (1).png',
        imageHeight: 400,
        title: "Build a better routine",
        titleTextStyle: GoogleFonts.nunito(
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0)),
        subTitle:
            'To begin using TickyFy, start by recording the habits you want to track in your life.',
        subTitleTextStyle: GoogleFonts.dekko(
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255))), //2ndonboarading
    Introduction(
      imageUrl: 'lib/assets/images/5615730_2895505-removebg-preview.png',
      imageHeight: 370,
      title: "Perosonalize your work",
      titleTextStyle: GoogleFonts.nunito(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0)),
      subTitle: 'Customize TickyFy to work for you. No opinions, just options.',
      subTitleTextStyle: GoogleFonts.dekko(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          color: const Color.fromARGB(255, 255, 255, 255)),
    ),
  ];
  OnBoardingPage({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        children: [
          Expanded(
            child: IntroScreenOnboarding(
              introductionList: list,
              backgroudColor: const Color.fromARGB(255, 153, 153, 255),
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              onTapSkipButton: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const WelomePage())),
              skipTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}