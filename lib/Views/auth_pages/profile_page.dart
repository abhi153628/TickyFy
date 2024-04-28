import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tickyfy/Views/habbits_page/habbit_home.dart';
import 'package:tickyfy/controllers/custom_widgets/snackbar.dart';
import 'package:tickyfy/model/database/auth_db_functions.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController profilenameController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'lib/assets/images/2.png',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 200,
                  width: 200,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 226, left: 14),
                      child: CircleAvatar(
                        radius: 97,
                        backgroundColor: Color.fromARGB(255, 0, 0, 0),
                        backgroundImage: AssetImage(
                          'lib/assets/images/images.png',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 226,
                    left: 109,
                  ),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider
                        : const AssetImage('lib/assets/images/images.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 380, left: 240),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 45,
                      color: Colors.white,
                    ),
                    onPressed: _getImage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 550.5),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        color: Color.fromARGB(200, 255, 253, 253)),
                    height: 326,
                    width: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Your Name',
                          style: GoogleFonts.aBeeZee(fontSize: 18),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 370,
                              height: 69,
                              child: TextFormField(
                                controller: profilenameController,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dekko(
                                    color: const Color.fromARGB(
                                      255,
                                      0,
                                      0,
                                      0,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: 40),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  filled: true, // Enable filling
                                  fillColor:
                                      const Color.fromARGB(205, 180, 180, 255),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Congratulations on taking the first step towards \n                     feeling more organized !',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: 400,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (profilenameController.text.isNotEmpty) {
                                    await addProfile(_image!.path,
                                        profilenameController.text);
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  } else {
                                    showSnackbar(
                                        context,
                                        'Please type yor name',
                                        const Color.fromARGB(255, 255, 0, 0));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 104, 70, 255),
                                  foregroundColor: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Create My Profile',
                                  style: GoogleFonts.dekko(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
