import 'package:flutter/material.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';

class AboutPage extends StatelessWidget {
 const AboutPage({super.key});
// Corrected super constructor syntax

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'About Tickyfy',
          color: white,
          fontSize: 24,
        ),
        backgroundColor: DarkPurple,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Tickyfy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Tickyfy is a revolutionary habit tracker designed to simplify your journey towards building positive habits. Inspired by the principles of "Atomic Habits" by James Clear, Tickyfy empowers users to cultivate a routine that leads to lasting change.\n\n'
                'Key Features:\n\n'
                '1. Customizable Reminders: Set personalized reminders for your habits to stay on track throughout the day. Tickyfy will prompt you at the perfect moment to ensure you never miss a beat.\n\n'
                '2. Intuitive Interface: With Tickyfy, managing your habits is as easy as a tap. Our user-friendly interface allows you to effortlessly add, edit, and track your habits with just a few swipes.\n\n'
                '3. Voice Input: Say goodbye to tedious manual input. Tickyfy\'s innovative speech-to-text feature enables you to effortlessly add new habits simply by speaking into your device.\n\n'
                '4. Data Security: We prioritize the privacy and security of your personal information. Tickyfy employs robust security measures to safeguard your data, ensuring your peace of mind as you focus on your journey towards self-improvement.\n\n'
                '5. Inspired by "Atomic Habits": Grounded in the principles of James Clear\'s bestselling book, Tickyfy is designed to help you implement tiny changes that yield remarkable results over time.\n\n'
                'Whether you\'re striving to exercise more, eat healthier, or boost your productivity, Tickyfy is your trusted companion on the path to a happier, healthier lifestyle.\n\n'
                'Download Tickyfy today and start building the habits that will transform your life.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
