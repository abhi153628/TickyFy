import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/auth_pages/about.dart';
import 'package:tickyfy/Views/auth_pages/privacypolicy.dart';
import 'package:tickyfy/Views/auth_pages/profile_page.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/model/database/auth_db_functions.dart';

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
              child: Container(
                decoration: BoxDecoration(
                  color: LightPurple,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 0, bottom: 80, right: .1),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset('lib/assets/images/9.png'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 166, left: 90),
                                    child: Text(
                                      'Hey!',
                                      style: GoogleFonts.alegreyaSans(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 185, left: 115),
                                    child: Text(
                                      snapshot.data!.name!,
                                      style: GoogleFonts.alegreyaSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 160, top: 38, left: 19),
                                    child: CircleAvatar(
                                      foregroundColor: const Color.fromARGB(
                                          255, 18, 16, 16),
                                      backgroundColor: const Color.fromARGB(
                                          31, 31, 25, 25),
                                      radius: 60,
                                      backgroundImage: image != null
                                          ? FileImage(image!) as ImageProvider
                                          : const AssetImage(
                                              'lib/assets/images/images.png'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 110, left: 110),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProfilePage()));
                                        },
                                        icon: Icon(
                                          Icons.camera_alt,
                                          size: 30,
                                          color: white,
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.app_registration,
                          color: white,
                          size: 25,
                        ),
                        title: CustomText(
                          text: 'Privacy Policy',
                          color: white,
                          fontSize: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PrivacyPolicy(
                                key: null,
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: white,
                          size: 20,
                        ),
                        title: CustomText(
                          text: 'About',
                          color: white,
                          fontSize: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                     AboutPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                   
                          CustomText(text: 'Version No 1.0.0', color: white, fontSize: 12)
                       
                    ],
                    
                  ),
                ),
              ),
            );
          } else {
            child = const Text('No data found');
          }
          return child;
        });
  }
}
