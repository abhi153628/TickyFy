import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/task_screens/localnotifi.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/snackbar.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
// ignore: must_be_immutable
class AddHabbitBottomSheet extends StatefulWidget {
  VoidCallback? onpressed;
  TextEditingController? controller;
  TextEditingController controller1;
AddHabbitBottomSheet({
    super.key,
    this.onpressed,
    this.controller,
    required this.controller1,
  });
@override
  State<AddHabbitBottomSheet> createState() => _AddHabbitBottomSheetState();
}

class _AddHabbitBottomSheetState extends State<AddHabbitBottomSheet> {
  String? selectedItem;
  TimeOfDay? selectedTime;
  bool isButtonPressed = false;
  bool isReminderOn = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  //Habit name validation function
  String? validateHabitName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please type the habit name!';
    } else if (value.trim().isEmpty) {
      return 'Habit name cannot be empty spaces!';
    } else if (value.length > 20) {
      return 'Habit name cannot exceed 20 characters!';
    } else if (value.contains(RegExp(r'[0-9]')) ||
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Habit name cannot contain numbers or symbols!';
    }
    return null;
  }

//question validation function
  String? validateQuestion(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please type a question!';
    } else if (value.trim().isEmpty) {
      return 'Question cannot be empty spaces!';
    } else if (value.length > 25) {
      return 'Question cannot exceed 20 characters!';
    } else if (value.contains(RegExp(r'[0-9]')) ||
        value.contains(RegExp(r'[!@#$%^&*(),.":{}|<>]'))) {
      return 'Question cannot contain numbers or symbols!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Create Habit', color: black, fontSize: 20),
              const SizedBox(height: 8),
              //!1st habit name textform field
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: CustomText(
                    text: 'Type the Habit Name', color: black, fontSize: 12),
              ),
              TextFormField(
                style: GoogleFonts.aBeeZee(color: white, fontSize: 18),
                controller: widget.controller,
                validator: validateHabitName,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: red, fontSize: 14),
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13, color: grey),
                  filled: true,
                  fillColor: DarkPurple,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  hintText: 'e.g.Excercise',
                ),
              ),
              const SizedBox(height: 9),
              //!habit question
              Padding(
                padding: const EdgeInsets.only(left: 17),
                child: CustomText(
                    text: 'Type the Question to Notify',
                    color: black,
                    fontSize: 12),
              ),
              TextFormField(
                style: GoogleFonts.aBeeZee(color: white, fontSize: 17),
                validator: validateQuestion,
                controller: widget.controller1,
                decoration: InputDecoration(
                    errorStyle:
                         TextStyle(color: red, fontSize: 14),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13, color: grey),
                    filled: true,
                    fillColor: DarkPurple,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    hintText: 'e.g.Did you do Excercise today?'),
              ),
              const SizedBox(
                height: 13,
              ),
              //time picker
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        {
                          _selectTime(context);
                        }
                      },
                      child: Text(
                        selectedTime != null
                            ? 'Time selected: ${selectedTime!.format(context)}'
                            : 'Select Time',
                        style: GoogleFonts.aBeeZee(
                            color: black, fontWeight: FontWeight.bold),
                      )),
                  const Spacer(),
                  //toggle button for remainder
                  Switch(
                    value: isReminderOn,
                    onChanged: remainderToggle,
                    activeTrackColor: black,
                    activeColor: Colors.lightGreenAccent,
                  ),
                ],
              ),

              const SizedBox(
                height: 23,
              ),

              // ignore: prefer_const_constructors
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onpressed!();
                        }
                      },
                      child: CustomText(
                          text: 'Create Habit',
                          color: DarkPurple,
                          fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void remainderToggle(bool value) {
    setState(() {
      isReminderOn = value;
    });
    if (isReminderOn) {
      //sheduling the notification it is on
      LocalNotificationService.showDailyScheduledNotification(
          time: selectedTime, question: widget.controller1.text);
      showCustomSucessSnackbar(context, 'Success',
          'Notification have been successfully updated', white);
    } else {
      LocalNotificationService.cancelNotification(3);
      showCustomSnackbar(
          context, 'Warning', 'Notification have been canceled', white);
    }
  }
}
