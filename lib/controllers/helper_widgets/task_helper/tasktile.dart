import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/popupmenu.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
import 'package:tickyfy/controllers/helper_widgets/bottom_sheet.dart';
import 'package:tickyfy/controllers/helper_widgets/task_helper/edit_task.dart';
import 'package:tickyfy/model/database/task_db.dart';
import 'package:tickyfy/model/model_class/task_model.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    var status = await _speechToText.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );
    print('Initialization status: $status');
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
      _isExpanded = _checkOverflow(result.recognizedWords);
    });
  }

  bool _checkOverflow(String text) {
    final textPainter = TextPainter(
        text: TextSpan(
            text: text,
            style: GoogleFonts.robotoCondensed(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold)),
        maxLines: 2,
        textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: 327);
    return textPainter.didExceedMaxLines;
  }

  final TextEditingController taskController = TextEditingController();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 5),
      child: Column(
        children: [
          Row(
            children: [
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
                    setState(() {
                      _isExpanded = !_isExpanded; // Toggle expansion state
                    });
                  },
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 238, 238, 238),
                        ),
                        height: _isExpanded || _checkOverflow(widget.spokenWords) ? null : 90,
                        width: 327,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 1, top: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      widget.taskName,
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: 20,
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
                                            context: context,
                                            builder: (BuildContext context) {
                                              return NotificationListener(
                                                child: CustomBottomSheet(
                                                  content: Column(
                                                    children: [
                                                      EditTaskSheet(
                                                        task: widget.task,
                                                        onpressed: () async {
                                                          TaskModel updatedTask = TaskModel(
                                                            taskName: taskController.text,
                                                            spokenWords: _wordsSpoken.value,
                                                          );
                                                          await TaskDbFunctions().editTask(widget.task.key, updatedTask);
                                                          Navigator.of(context).pop();
                                                        },
                                                        condition: _speechToText.isNotListening && _confidenceLevel > 0,
                                                        text2: "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                                                        text3: _wordsSpoken,
                                                        icon: _speechToText.isListening ? Icons.mic_off : Icons.mic,
                                                        onpressed2: _speechToText.isListening ? _stopListening : _startListening,
                                                        controller: taskController,
                                                      ),
                                                    ],
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
                                          TaskDbFunctions ab = TaskDbFunctions();
                                          await ab.deleteTask(widget.task.key);
                                        },
                                      )
                                    ],
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              if (_isExpanded || _checkOverflow(widget.spokenWords))
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 2),
                                  child: Text(
                                    widget.spokenWords,
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 133, 132, 132),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
