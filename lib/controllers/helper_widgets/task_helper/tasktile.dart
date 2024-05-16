import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/popupmenu.dart';
import 'package:tickyfy/controllers/custom_widgets/show_dialog.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/controllers/helper_widgets/task_helper/edit_task.dart';
import 'package:tickyfy/model/database/task_db.dart';
import 'package:tickyfy/model/model_class/task_model.dart';

// ignore: must_be_immutable
class TaskTile extends StatefulWidget {
  final String taskName;
  String spokenWords;
  int? tasknumber;
  TaskModel task;

  TaskTile(
      {super.key,
      required this.task,
      required this.taskName,
      this.spokenWords = '',
      this.tasknumber});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  List<DateTime> dateList = [];
  final ValueNotifier _wordsSpoken = ValueNotifier('');
  double _confidenceLevel = 0;
  //instance of speech
  final SpeechToText _speechToText = SpeechToText();
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
   await _speechToText.initialize(
      // ignore: avoid_print
      onStatus: (status) => print('Status: $status'),
      // ignore: avoid_print
      onError: (error) => print('Error: $error'),
    );
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken.value = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  final TextEditingController taskController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30, left: 5),
        child: Column(children: [
          Row(children: [
            SizedBox(
              height: 90,
              width: 55,
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CustomText(
                  text: "#${widget.tasknumber.toString()}",
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 7),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return NotificationListener(
                          child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [white, LightPurple]),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ValueListenableBuilder(
                                        valueListenable: taskNotifierList,
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CustomText(
                                                        text: 'Task Name :',
                                                        color: black,
                                                        fontSize: 15),
                                                        const SizedBox(width: 20,),
                                                        CustomText(
                                                    text: widget.task.taskName,
                                                    color: black,
                                                    fontSize: 20),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                
                                                CustomText(
                                                    text: "Word's Spoken :",
                                                    color: black,
                                                    fontSize: 15),
                                                CustomText(
                                                    text: widget.task.spokenWords,
                                                    color: black,
                                                    fontSize: 20),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 238, 238, 238),
                    ),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.2,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1, top: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //pop up menu button
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  widget.taskName,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              CustomPopUpButton(
                                items: [
                                  MenuItem(
                                    icon: Icons.edit,
                                    title: 'Edit',
                                    onTap: () async {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return NotificationListener(
                                            child: Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        white,
                                                        LightPurple
                                                      ]),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: EditTaskSheet(
                                                        task: widget.task,
                                                        onpressed: () async {
                                                          TaskModel
                                                              updatedTask =
                                                              TaskModel(
                                                            taskName:
                                                                taskController
                                                                    .text,
                                                            spokenWords:
                                                                _wordsSpoken
                                                                    .value,
                                                          );
                                                          await TaskDbFunctions()
                                                              .editTask(
                                                                  widget
                                                                      .task.key,
                                                                  updatedTask);
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        condition: _speechToText
                                                                .isNotListening &&
                                                            _confidenceLevel >
                                                                0,
                                                        text2:
                                                            "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                                                        text3: _wordsSpoken,
                                                        icon: _speechToText
                                                                .isListening
                                                            ? Icons.mic_off
                                                            : Icons.mic,
                                                        onpressed2: _speechToText
                                                                .isListening
                                                            ? _stopListening
                                                            : _startListening,
                                                        controller:
                                                            taskController,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  MenuItem(
                                    icon: Icons.delete,
                                    title: 'Delete',
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomAlertDialog(
                                            title: 'Delete',
                                            content:
                                                'Are you sure you want to delete?',
                                            confirmButtonText: 'OK',
                                            cancelButtonText: 'Cancel',
                                            onConfirmPressed: () async {
                                              Navigator.of(context).pop();
                                              try {
                                                TaskDbFunctions ab =
                                                    TaskDbFunctions();
                                                await ab.deleteTask(
                                                    widget.task.key);
                                                // ignore: empty_catches
                                              } catch (error) {}
                                            },
                                            onCancelPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                                  )
                                ],
                                color: Colors.black,
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 2),
                            child: Text(
                              widget.spokenWords,
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 17,
                                color: const Color.fromARGB(255, 133, 132, 132),
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ])
        ]));
  }
}
