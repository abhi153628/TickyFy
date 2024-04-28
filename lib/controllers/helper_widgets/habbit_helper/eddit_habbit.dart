import 'package:flutter/material.dart';
import 'package:tickyfy/model/model_class/habit_model.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = widget.controller;
    questionController = widget.controller1;
    nameController.text = widget.habbit.habbitName;
    questionController.text = widget.habbit.habbitQuestion!;
  }

  String? selectedItem;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isButtonPressed = false;

  final List<String> _dropdownItems = [
    'Daily',
    'Weekly',
    'Monthly',
  ];

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
            DropdownButtonFormField(
              value: selectedItem,
              items: _dropdownItems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                selectedItem = value;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Frequency',
                  hintText: 'Every day'),
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
}
