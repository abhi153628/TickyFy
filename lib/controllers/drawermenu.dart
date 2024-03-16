import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tickyfy/Views/home_page.dart';
import 'package:tickyfy/Views/login_page.dart';
import 'package:tickyfy/controllers/color_controller.dart';
import 'package:tickyfy/database/db_functions.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.connectionState == ConnectionState.waiting) {
            child = const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            child = Text(
              'Error: ${snapshot.error}',
            );
          } else if (snapshot.hasData) {
            image = File(snapshot.data!.image!);

            child = Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    color: LightPurple,
                    height: 200,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          foregroundColor:
                              const Color.fromARGB(255, 18, 16, 16),
                          backgroundColor: const Color.fromARGB(31, 31, 25, 25),
                          radius: 70,
                          backgroundImage: image != null
                              ? FileImage(image!) as ImageProvider
                              : const AssetImage(
                                  'lib/assets/images/images.png'),
                        ),

                        ///NAME OF THE USER
                        Text(snapshot.data!.name!,
                            style: TextStyle(color: white))
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.app_registration),
                    title: const Text(
                      'Privacy and policy',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const HomePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'About',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    //naviagting to home page
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  HomePage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            // ignore: unused_local_variable
                            var offsetAnimation = animation.drive(tween);

                            return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 500),
                    child: SizedBox(
                      height: 40,
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightPurple,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Logout'),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            child = const Text('No data found');
          }
          return child;
        });
  }
}
