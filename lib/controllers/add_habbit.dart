import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddHabbitBottomSheet extends StatefulWidget {
  VoidCallback? onpressed;
  TextEditingController? controller;
  TextEditingController controller1;

  AddHabbitBottomSheet(
      {super.key,
      required this.onpressed,
      this.controller,
      required this.controller1});

  @override
  State<AddHabbitBottomSheet> createState() => _AddHabbitBottomSheetState();
}

class _AddHabbitBottomSheetState extends State<AddHabbitBottomSheet> {
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
    return GestureDetector(
                    onTap: () {
                    FocusScope.of(context).unfocus(); // Dismiss keyboard
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
}
