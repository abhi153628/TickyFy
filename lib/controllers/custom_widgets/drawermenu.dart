import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/auth_pages/profile_page.dart';
import 'package:tickyfy/Views/auth_pages/signup_page.dart';
import 'package:tickyfy/Views/habbits_page/habbit_home.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/elevated_button.dart';
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
              
              
            
              child: Padding(
                 padding: const EdgeInsets.only(top: 0),
                child: Container(
                             
                
                  decoration: BoxDecoration(
                    color: LightPurple,
                  ),
                  child: 
                      Padding(
                        padding: const EdgeInsets.only(top: 0,bottom: 80,right: .1),
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
                                          padding: const EdgeInsets.only(top: 166, left: 90),
                                          child: Text('Hey!',
                                              style: GoogleFonts.alegreyaSans(fontSize: 17,fontWeight: FontWeight.bold),
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 185, left: 115),
                                          child: Text(
                                            snapshot.data!.name!,
                                            style: GoogleFonts.alegreyaSans(fontSize: 20,fontWeight: FontWeight.bold,color: white),
                                          overflow: TextOverflow.ellipsis, ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 160, top: 38,left: 19),
                                          child: CircleAvatar(
                                            foregroundColor:
                                                const Color.fromARGB(
                                                    255, 18, 16, 16),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    31, 31, 25, 25),
                                            radius: 60,
                                            backgroundImage: image != null
                                                ? FileImage(image!)
                                                    as ImageProvider
                                                : const AssetImage(
                                                    'lib/assets/images/images.png'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 110,left: 110),
                                          child: IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ProfilePage()));}, icon: Icon(Icons.camera_alt,size: 30,color: white,)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const HomePage(),
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
                     SizedBox(width: 150,child: Padding(
                       padding: const EdgeInsets.only(top: 310,),
                       child: CustomElevatedButton(text: 'Logout', onpressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupPage())); },),
                     )),
                    
                  
                          ],
                        ),
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
