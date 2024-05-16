import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/auth_pages/about.dart';

import 'package:tickyfy/Views/auth_pages/profile_page.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/elevated_button.dart';



class WelomePage extends StatelessWidget {
  const WelomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'lib/assets/images/1.png',
                  fit: BoxFit.fill,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              'lib/assets/images/App_logo.png',
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              'Pop things done',
                              style: GoogleFonts.dekko(fontSize: 15),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            Text(
                              'Welcome to TickyFy',
                              style: GoogleFonts.sacramento(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 450,
                            ),
                           
                            SizedBox(
                              width: 180,
                              height: 50,
                              child: CustomElevatedButton(
                                onpressed: () {
                                   Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ProfilePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                  (Route<dynamic> route) =>
                      false, // Removes all routes until this new route
                );
                                },
                                text: "Let's Start",
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                              onPressed: () {
                               Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const AboutPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                  (Route<dynamic> route) =>
                      false, 
                );
                               
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: white),
                              ),
                              child: Text(
                                'About App',
                                style: GoogleFonts.aBeeZee(
                                    color:white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
