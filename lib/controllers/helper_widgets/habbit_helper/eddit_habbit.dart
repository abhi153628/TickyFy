import 'package:flutter/material.dart';
import 'package:tickyfy/Views/task_screens/localnotifi.dart';
import 'package:tickyfy/model/model_class/habit_model.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/snackbar.dart';

// ignore: must_be_immutable
class EditHabbitBottomSheet extends StatefulWidget {
  HabitModel habbit;
  VoidCallback? onpressed;
  TextEditingController controller;
  TextEditingController controller1;

  EditHabbitBottomSheet(
      {super.key,
      required this.habbit,
      required this.onpressed,
      required this.controller,
      required this.controller1});            

  @override
  State<EditHabbitBottomSheet> createState() => _EditHabbitBottomSheetState();
}

class _EditHabbitBottomSheetState extends State<EditHabbitBottomSheet> {
  late TextEditingController nameController;
  late TextEditingController questionController;
  String? selectedItem;
  TimeOfDay? selectedTime;
  bool isButtonPressed = false;
  bool isReminderOn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = widget.controller;
    questionController = widget.controller1;
    nameController.text = widget.habbit.habbitName;
    questionController.text = widget.habbit.habbitQuestion!;
  }

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




  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Habbit',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: widget.controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'e.g.Excercise',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a question';
                }
                return null;
              },
              controller: widget.controller1,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Question',
                  hintText: 'e.g.Did you do Excercise today?'),
            ),
            const SizedBox(
              height: 8,
            ),
             //time picker
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Text(selectedTime != null
                        ? 'Time selected: ${selectedTime!.format(context)}'
                        : 'Select Time'),
                  ),
                  Spacer(),
                  //toggle button for remainder
             Switch(
          value: isReminderOn,
          onChanged: remainderToggle,
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 23,
              ),

          
          
            // ignore: prefer_const_constructors
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        widget.habbit.habbitName = nameController.text;
                        widget.habbit.habbitQuestion = questionController.text;
                        widget.onpressed!();
                      }
                    },
                    child: const Text('Edit habbit')),
              ],
            ),
          ],
        ),
      ),
    );
  }
    void remainderToggle(bool value)
  {
    setState(() {
      isReminderOn=value;
    });
    if(isReminderOn){
      //sheduling the notification it is on
      LocalNotificationService.showDailyScheduledNotification(time: selectedTime, question: '');
      showSnackbar(context, 'Notification sheduled', red);

    }else{
      LocalNotificationService.cancelNotification(3);
      showSnackbar(context, 'notification canceled', red);
    }
  }
}
