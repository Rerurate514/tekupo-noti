import 'package:flutter/material.dart';
import 'package:tekupo_noti/controllers/notifyActiveGridController.dart';
import 'package:tekupo_noti/settings/gridSettings.dart';
import 'package:tekupo_noti/widgets/weekLabel.dart';

class ScheduleGrid extends StatefulWidget {
  const ScheduleGrid({super.key});

  @override
  _ScheduleGridState createState() => _ScheduleGridState();
}

class _ScheduleGridState extends State<ScheduleGrid> {
  final NotifyActiveGridController _nagc = NotifyActiveGridController();

  @override
  void initState(){
    _nagc.initGrid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        WeekLabel(),
        for(var scheduleTime in ScheduleTime.values) buildRow(scheduleTime)
      ],
    );
  }

  Widget buildRow(ScheduleTime scheduleTime){
    return Row(
      children: [
        buildScheduleLabel(scheduleTime),
        for(var dayOfWeek in DayOfWeek.values) buildNoticeGridBlock(dayOfWeek, scheduleTime)
      ],
    );
  }

  Widget buildScheduleLabel(ScheduleTime scheduleTime){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * GridSettings.horizontal.factor,
      height: size.height * GridSettings.vertical.factor,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                scheduleTime.num.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13
                ),
              ),
              Text(
                scheduleTime.minuteStr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget buildNoticeGridBlock(DayOfWeek dayOfWeek, ScheduleTime scheduleTime){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * GridSettings.horizontal.factor,
      height: size.height * GridSettings.vertical.factor,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 3000),
        switchInCurve: Curves.bounceIn,
        switchOutCurve: Curves.bounceOut,
        child: _nagc.getActiveGrid(dayOfWeek: dayOfWeek, scheduleTime: scheduleTime)
          ? Card(
            color: Colors.tealAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            child: InkWell(
              radius: 4,
              onTap: () {
                setState(() {
                  _nagc.toggleActiveGrid(dayOfWeek: dayOfWeek, scheduleTime: scheduleTime);
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.035, horizontal: size.width * 0.02),
                child: const Icon(Icons.notifications),
              )
            )
          )
          : Card(
            color: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            ),
            child: InkWell(
              radius: 4,
              onTap: () {
                setState(() {
                  _nagc.toggleActiveGrid(dayOfWeek: dayOfWeek, scheduleTime: scheduleTime);
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.035, horizontal: size.width * 0.02),
                child: const Icon(Icons.notifications_off),
              )
            ),
        )
      )
    );
  }
}

enum ScheduleTime{
  ONE,
  TWO,
  THREE,
  FOUR,
  FIVE,
  SIX
}

extension ScheduleTimeEx on ScheduleTime{
  String get minuteStr{
    switch(this){
      case ScheduleTime.ONE: return " 8:50\n    ~ \n10:30";
      case ScheduleTime.TWO: return "10:40\n    ~ \n12:20";
      case ScheduleTime.THREE: return "13:10\n    ~ \n14:50";
      case ScheduleTime.FOUR: return "15:00\n    ~ \n16:40";
      case ScheduleTime.FIVE: return "16:50\n    ~ \n18:30";
      case ScheduleTime.SIX: return "18:40\n    ~ \n20:20";
    }
  }

  int get num{
    switch(this){
      case ScheduleTime.ONE: return 1;
      case ScheduleTime.TWO: return 2;
      case ScheduleTime.THREE: return 3;
      case ScheduleTime.FOUR: return 4;
      case ScheduleTime.FIVE: return 5;
      case ScheduleTime.SIX: return 6;
    }
  }
}
