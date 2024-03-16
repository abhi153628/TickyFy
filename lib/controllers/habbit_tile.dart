import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/Views/habbit_showpage.dart';
import 'package:tickyfy/controllers/animationbutton.dart';
import 'package:tickyfy/controllers/color_controller.dart';

// ignore: must_be_immutable
class HabbitTile extends StatefulWidget {
  String habbitName;
  bool? habbitCompleted;
  Function(bool?)? onChanged;
  VoidCallback onpressed1;
  VoidCallback onpressed2;
  VoidCallback onTap;
  HabbitTile({
    super.key,
    required this.habbitName,
    required this.habbitCompleted,
    required this.onChanged,
    required this.onpressed1,
    required this.onpressed2,
    required this.onTap,
  });

  @override
  State<HabbitTile> createState() => _HabbitTileState();
}

class _HabbitTileState extends State<HabbitTile> {
  bool _isChecked = false;
  ScrollController controller = ScrollController();
  ScrollController controller1 = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      controller1.jumpTo(controller.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //text container
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 3),
              child: GestureDetector(
                //! navigating to habbit show page
                onTap:widget.onTap ,
                //text container
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 220, 199, 252),
                    borderRadius: BorderRadius.only(
                      //to set the size of the text container
                      topRight: Radius.circular(.1),
                      bottomRight: Radius.circular(.1),
                      bottomLeft: Radius.circular(4),
                      topLeft: Radius.circular(4),
                    ),
                  ),
                  height: 35,
                  width: 150,
                  child: SizedBox(
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 7),
                        child: Text(
                          widget.habbitName,
                          style: GoogleFonts.robotoCondensed(
                              fontSize: 17,
                              color: black,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                ),
              ),
            ),
            Padding(
              //padding for checkbox container
              padding: const EdgeInsets.only(left: 2, top: 3, right: 4.8),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 220, 199, 252),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(.1),
                    bottomLeft: Radius.circular(.1),
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                height: 35,
                width: 250,
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemExtent: 50,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 40,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                        child: Stack(alignment: Alignment.center, children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            //type of animation u can set
                            curve: Curves.fastEaseInToSlowEaseOut,
                            transform: Matrix4.diagonal3Values(
                                _isChecked ? 1.2 : 1.0,
                                _isChecked ? 1.2 : 1.0,
                                1.0),
                            child: Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                value: widget.habbitCompleted ?? false,
                                onChanged: widget.onChanged,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: widget.habbitCompleted ?? false,
                          onChanged: widget.onChanged,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: widget.habbitCompleted ?? true,
                          onChanged: widget.onChanged,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: widget.habbitCompleted ?? true,
                          onChanged: widget.onChanged,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: widget.habbitCompleted ?? true,
                          onChanged: widget.onChanged,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: widget.habbitCompleted ?? true,
                          onChanged: widget.onChanged,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
