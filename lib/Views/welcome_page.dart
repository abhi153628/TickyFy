import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/controllers/cstm_button.dart';
import 'package:tickyfy/views/login_page.dart';
import 'package:tickyfy/views/signup_page.dart';

import '../controllers/color_controller.dart';

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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                text: 'Login',
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignupPage(),
                                  ),
                                );
                                //navigation of signup button
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: white),
                              ),
                              child: Text(
                                'Sign Up',
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
