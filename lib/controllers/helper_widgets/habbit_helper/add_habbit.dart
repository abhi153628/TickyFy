import 'package:flutter/material.dart';
import 'package:tickyfy/Views/task_screens/localnotifi.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/snackbar.dart';

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
                          widget.onpressed!();
                        }
                      },
                      child: const Text('Create habbit')),
                ],
              ),
            ],
          ),
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
      LocalNotificationService.showDailyScheduledNotification(time: selectedTime, question:'');
      showSnackbar(context, 'Notification sheduled', red);

    }else{
      LocalNotificationService.cancelNotification(3);
      showSnackbar(context, 'notification canceled', red);
    }
  }
}
