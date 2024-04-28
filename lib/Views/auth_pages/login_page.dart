import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/habbits_page/habbit_home.dart';
import 'package:tickyfy/controllers/custom_widgets/elevated_button.dart';
import 'package:tickyfy/controllers/custom_widgets/cstm_form_field.dart';
import 'package:tickyfy/model/database/auth_db_functions.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool uservalidator = false;
  bool passwordValidator = false;
  void showSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 97, 72, 195),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 97, 72, 195),
            child: Stack(
              children: [
                Image.asset(
                  'lib/assets/images/WhatsApp Image 2024-02-19 at 13.17.59_7cbf18cb.jpg',
                  height: screenHeight,
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      12, screenHeight * 0.065, 4, screenHeight * 0.006),
                  child: Text(
                    'Hey, Welcome back',
                    style: GoogleFonts.alegreyaSans(
                      fontSize: screenWidth * 0.043,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      12, screenHeight * 0.12, 4, screenHeight * 0.036),
                  child: Text(
                    'Login',
                    style: GoogleFonts.alegreyaSc(
                      fontSize: screenWidth * 0.072,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 580,
                    ),
                    SizedBox(
                      width: screenWidth * 0.857,
                      child: Padding(
             padding: const EdgeInsets.only(left: 50),
                        child: CustomFormField(
                          validator: uservalidator,
                          errortext: "Username can't be empty",
                          controller: userController,
                          hintText: 'Type Username',
                          labeltext: 'Username',
                          icon: Icons.person,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: screenWidth * 0.857,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: CustomFormField(
                          validator: passwordValidator,
                          errortext: "Password can't be empty",
                          controller: passwordController,
                          icon: Icons.lock,
                          hintText: 'Enter Password',
                          labeltext: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: screenWidth * 0.320,
                      child: CustomElevatedButton(
                        text: 'Login',
                        fontSize: screenWidth * 0.048,
                        onpressed: () async {
                          if (userController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            showSnackbar(
                              context,
                              'Username or Password can\'t be empty',
                              Colors.red,
                            );
                            return;
                          }
                          //whether the user signup or not already logined or not
                          var checkSignup = await validateUser(
                            userController.text,
                            passwordController.text,
                          );
                          if (checkSignup == true) {
                            setCheckLogin(true);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>  const HomePage(),
                              ),
                              (route) => false,
                            );
                          } else {
                            // ignore: use_build_context_synchronously
                            showSnackbar(
                              context,
                              'Invalid username or password',
                              Colors.red,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
