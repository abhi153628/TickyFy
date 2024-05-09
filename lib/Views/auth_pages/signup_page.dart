import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/auth_pages/login_page.dart';
import 'package:tickyfy/Views/auth_pages/profile_page.dart';

import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/elevated_button.dart';
import 'package:tickyfy/controllers/custom_widgets/cstm_form_field.dart';
import 'package:tickyfy/controllers/custom_widgets/snackbar.dart';
import 'package:tickyfy/model/database/auth_db_functions.dart';
import 'package:tickyfy/model/model_class/user_model.dart';


class SignupPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  SignupPage({Key? key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();
  bool userValidator = false;
  bool passwordValidator = false;
  bool conformPasswordValidator = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                'lib/assets/images/WhatsApp Image 2024-02-19 at 13.18.37_50234a24.jpg',
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 60, 4, 5),
                child: Text(
                  'Hey, Welcome ',
                  style: GoogleFonts.alegreyaSans(
                    fontSize: 23,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 90, 4, 18),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.alegreyaSansSc(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const SizedBox(height: 300),
                    SizedBox(
                      width: 380,
                      child: CustomFormField(
                        validator: userValidator,
                        errortext: "Username can't be empty",
                        controller: userController,
                        hintText: 'Type Username..',
                        icon: Icons.person,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 380,
                      child: CustomFormField(
                        validator: passwordValidator,
                        errortext: "Password can't be empty",
                        controller: passwordController,
                        hintText: 'Type Password..',
                        icon: Icons.lock,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 380,
                      child: CustomFormField(
                        validator: conformPasswordValidator,
                        errortext: "Password can't be empty",
                        controller: conformPasswordController,
                        hintText: 'Conform Password',
                        icon: Icons.lock,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200, top: 630),
                child: SizedBox(
                  width: 174,
                  child: CustomElevatedButton(
                    onpressed: () async {
                      if (userController.text.length < 4) {
                        showSnackbar(
                          context,
                          'Username must be at least 4 characters long.',
                          Colors.red,
                        );
                      } else if (passwordController.text.length < 4) {
                        showSnackbar(
                          context,
                          'Password must be at least 4 characters long.',
                          Colors.red,
                        );
                      } else if (!passwordController.text
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        showSnackbar(
                          context,
                          'Password must contain at least one special character.',
                          Colors.red,
                        );
                      } else if (!passwordController.text
                          .contains(RegExp(r'[0-9]'))) {
                        showSnackbar(
                          context,
                          'Password must contain at least one digit.',
                          Colors.red,
                        );
                      } else if (passwordController.text !=
                          conformPasswordController.text) {
                        showSnackbar(
                          context,
                          'Passwords do not match. Please re-enter your password',
                          Colors.red,
                        );
                      } else {
                      
                        await addUser(User(
                          username: userController.text,
                          password: passwordController.text,
                        ));
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    text: 'Create Account',
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(
                  top: 685,
                  left: 200,
                ),
                child: Text(
                  'Already have an Account?',
                  style: GoogleFonts.aBeeZee(fontSize: 13, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 310, top: 696),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) => const LoginPage()));
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 600,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Image.asset(
                      'lib/assets/images/Whoaphoto.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
