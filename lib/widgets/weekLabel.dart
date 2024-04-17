import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

enum DayOfWeek{
  SUNDAY,
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  TURSDAy,
  FRIDAY,
  SATURDAY
}

extension DayOfWeekJpEx on DayOfWeek{
  String get jpStr{
    switch(this){
      case DayOfWeek.SUNDAY: return "日";
      case DayOfWeek.MONDAY: return "月";
      case DayOfWeek.TUESDAY: return "火";
      case DayOfWeek.WEDNESDAY: return "水";
      case DayOfWeek.TURSDAy: return "木";
      case DayOfWeek.FRIDAY: return "金";
      case DayOfWeek.SATURDAY: return "土";
    }
  } 
}
