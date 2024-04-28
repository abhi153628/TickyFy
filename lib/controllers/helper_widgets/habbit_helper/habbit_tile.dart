import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickyfy/controllers/custom_widgets/color_controller.dart';


class HabbitTile extends StatefulWidget {
  final String habbitName;

  final VoidCallback onTap;

  const HabbitTile({
    super.key,
    required this.habbitName,

    required this.onTap, String? habbitQuestion,
  });

  @override
  State<HabbitTile> createState() => _HabbitTileState();
}

class _HabbitTileState extends State<HabbitTile> {
  bool _isChecked = false;
  List<DateTime> dateList=[];
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Row(
          children: [
            // Text container
            Padding(
              padding:  const EdgeInsets.only(left: 4, top: 3),
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  decoration:  BoxDecoration(
                    color:DarkPurple,//color
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(  5),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5),
                    ),
                  ),
                  height: 36,
                  width: 151,
                  child: SizedBox(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 6),
                      child: Text(
                        widget.habbitName,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 17,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Checkbox container
          
          ],
        ),
      ],
    );
  }

  getDates(DateTime startDate)
  {
for (DateTime date = startDate; date.isBefore(DateTime.now()); date = date.add(const Duration(days: 1))) {
    dateList.add(date);
  }
  }
}

