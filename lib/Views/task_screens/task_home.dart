import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/fab_button.dart';
import 'package:tickyfy/controllers/custom_widgets/snackbar.dart';
import 'package:tickyfy/controllers/helper_widgets/task_helper/addtask.dart';
import 'package:tickyfy/controllers/helper_widgets/task_helper/tasktile.dart';
import 'package:tickyfy/model/database/task_db.dart';
import 'package:tickyfy/model/model_class/task_model.dart';

class TaskHomePage extends StatefulWidget {
  final TaskModel? task;
  TaskHomePage({Key? key, this.task}) : super(key: key);

  @override
  _TaskHomePageState createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage>
    with SingleTickerProviderStateMixin {
  bool _speechEnabled = false;
  String _wordsSpoken = "";
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
    _speechEnabled = await _speechToText.initialize();
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
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  // animation when mic is pressed
  bool _isAnimationVisible = false;

  void _startAnimation() {
    setState(() {
      _isAnimationVisible = true;
    });
  }

  void _stopAnimation() {
    setState(() {
      _isAnimationVisible = false;
    });
  }

  final TextEditingController taskController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePageColor,
      body: taskNotifierList.value.isNotEmpty
          ? ValueListenableBuilder(
              valueListenable: taskNotifierList,
              builder:
                  (BuildContext context, List<TaskModel> value, Widget? child) {
                return Row(children: [
                  SizedBox(
                    width: 410,
                    child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TaskTile(
                            taskName: value[index].taskName,
                            tasknumber: index + 1,//displaying the voice number
                           
                          );
                        }),
                  ),
                ]);
              })
          : const Center(
              child: Text('Add Voices'),
            ),
      floatingActionButton: AddButton(
        onpressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
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
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AddTaskSheet(
                          controller: taskController,
                         
                          onpressed: () async {
                            if (taskController.text.isEmpty&&_wordsSpoken.isEmpty) {
                              // Handle empty task name
                            } else {
                              await TaskDbFunctions().addTask(TaskModel(
                                  taskName: taskController.text,
                                   spokenWords: _wordsSpoken,
                                 ));

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => TaskHomePage()),
                              );
                            }
                          },

                          onpressed2: _speechToText.isListening
                              ? _stopListening
                              : _startListening,
                          icon: _speechToText.isListening
                              ? Icons.mic_off
                              : Icons.mic,

                          //this is for confidence level printing

                          condition: _speechToText.isNotListening &&
                              _confidenceLevel > 0,
                              //confidence 
                          text2:
                              "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                              //this is the text where speech to text is happening

                          text3: _wordsSpoken,
                        ),
                      ),
                    ],
                   
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
