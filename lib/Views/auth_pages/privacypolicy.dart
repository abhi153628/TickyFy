import 'package:flutter/material.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';

class PrivacyPolicy extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  PrivacyPolicy({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Privacy policy',
          color: white,
          fontSize: 24,
        ),
        backgroundColor: DarkPurple,
      ),
      body: const SingleChildScrollView( // Added SingleChildScrollView to allow scrolling
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                // Privacy policy text goes here
                'At Tickyfy, we prioritize the confidentiality and security of your personal information. This Privacy Policy outlines how Tickyfy, its affiliates, and partners ("we," "our," or "us") collect, use, and safeguard your data through our habit tracker application.\n\n'
                'Collection of Your Information\n\n'
                'When you utilize Tickyfy, we may gather and store the information you provide to us. This includes data such as your habits, reminders, and any other content you choose to input into the app. We may also collect usage information to improve our services and understand user behavior.\n\n'
                'Use of Your Information\n\n'
                'The information we collect is used to personalize your experience within the app, including providing reminders for your habits and tracking your progress. We may also analyze aggregated data to improve Tickyfy and offer tailored features.\n\n'
                'Speech to Text Feature\n\n'
                'Tickyfy offers a speech-to-text feature, allowing users to input data through voice commands. These commands are processed within the app and are not stored or shared externally.\n\n'
                'Third-Party Services\n\n'
                'We may integrate third-party services to enhance Tickyfy\'s functionality, such as push notification services for reminders. These services are governed by their respective privacy policies, and we encourage users to review them.\n\n'
                'Data Security\n\n'
                'We employ industry-standard measures to protect your data from unauthorized access or disclosure. However, please note that no method of transmission over the internet or electronic storage is entirely secure.\n\n'
                'Children\'s Privacy\n\n'
                'Tickyfy is intended for users aged 18 and above. We do not knowingly collect personal information from children under this age. If we become aware of such information being collected, we will take steps to delete it promptly.\n\n'
                'Changes to Privacy Policy\n\n'
                'We reserve the right to update this Privacy Policy as needed. Any changes will be communicated through the app or via email. By continuing to use Tickyfy after such modifications, you consent to the revised terms.\n\n'
                'Contact Us\n\n'
                'If you have any questions or concerns regarding this Privacy Policy or your data, please contact us at 8590646692.\n\n'
                'Last Updated: 20-08-2024',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
