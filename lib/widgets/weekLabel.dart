import 'package:flutter/material.dart';
import 'package:tekupo_noti/enums/dayOfWeek.dart';

class WeekLabel extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        buildWeekLabelCom(context),
        for(var dayOfWeek in DayOfWeek.values) buildWeekLabelCom(context, dayOfWeek)
      ],
    );
  }

  Widget buildWeekLabelCom(BuildContext context, [DayOfWeek? dayOfWeek]){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.124,
      height: size.height * 0.059,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              dayOfWeek?.jpStr ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          )
        ),
      ),
    );
  }
}
