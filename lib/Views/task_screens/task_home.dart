import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';
import 'package:tickyfy/controllers/custom_widgets/drawermenu.dart';
import 'package:tickyfy/controllers/custom_widgets/fab_button.dart';
import 'package:tickyfy/controllers/custom_widgets/textstyle.dart';
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
    });
  }



  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePageColor,
       appBar: AppBar(
        backgroundColor: homePageColor,
        title:CustomText(text: 'Vocalize Your Goals', color: black, fontSize: 20)
      ),
      body: ValueListenableBuilder(
              valueListenable: taskNotifierList,
              builder:
                  (BuildContext context, List<TaskModel> value, Widget? child) {
                    print('object');
                return taskNotifierList.value.isNotEmpty
          ?  Row(children: [
                  SizedBox(
                    width: 410,
                    child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TaskTile(
                            task:value[index] ,
                              taskName: value[index].taskName,
                              tasknumber:
                                  index + 1, //displaying the voice number
                              spokenWords: value[index].spokenWords );
                        }),
                  ),
                ])
                : const Center(
              child: Text('Add Voices'),
            );
              }),
          
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
                            if (taskController.text.isEmpty &&
                                _wordsSpoken.value.isEmpty) {
                              // Handle empty task name
                            } else {
                              await TaskDbFunctions().addTask(TaskModel(
                                taskName: taskController.text,
                                spokenWords: _wordsSpoken.value,
                              )).then((_) =>Navigator.of(context).pop() );
                             taskController.text='';
                                  _wordsSpoken.value = '';
                             

                              // ignore: use_build_context_synchronously
                              
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

                          //! speech to text
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
        drawer: const CustomDrawer(),
    );
  }
}
