import 'package:flutter/material.dart';
import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';
import 'package:tekupo_noti/logic/notify/deleteSchedule.dart';
import 'package:tekupo_noti/logic/notify/notifyActionBtnsConfig.dart';
import 'package:tekupo_noti/logic/notify/registerSchedule.dart';
import 'package:tekupo_noti/logic/sharedPrefsManager.dart';
import 'package:tekupo_noti/models/notity.dart';
import 'package:tekupo_noti/providers/gridProvider.dart';
import 'package:tekupo_noti/settings/gridSettings.dart';
import 'package:tekupo_noti/widgets/weekLabel.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleGrid extends ConsumerStatefulWidget {
  const ScheduleGrid({super.key});

  @override
  ScheduleGridState createState() => ScheduleGridState();
}

class ScheduleGridState extends ConsumerState<ScheduleGrid> {
  final ScheduleRegistry _registry = ScheduleRegistry();
  final ScheduleDeleter _deleter = ScheduleDeleter();
  final SharedPrefsManager _prefsManager = SharedPrefsManager();

  @override
  void initState(){
    super.initState();
  }

  void _registerScheduleNotify(ScheduleTime scheduleTime, DayOfWeek dayOfWeek) async {
    _registry.registerScheduleNotify(scheduleTime, dayOfWeek, Before10minNotifier(), NotifyActionBtnsConfig(scheduleTime, dayOfWeek));
    _registry.registerScheduleNotify(scheduleTime, dayOfWeek, StartLessonNotifier(), NotifyActionBtnsConfig(scheduleTime, dayOfWeek));
    _registry.registerScheduleNotify(scheduleTime, dayOfWeek, After5minNotifier(), NotifyActionBtnsConfig(scheduleTime, dayOfWeek));
  }

  void _deleteScheduleNotify(ScheduleTime scheduleTime, DayOfWeek dayOfWeek) async {
    _deleter.deleteScheduleNotify(scheduleTime, dayOfWeek, Before10minNotifier());
    _deleter.deleteScheduleNotify(scheduleTime, dayOfWeek, StartLessonNotifier());
    _deleter.deleteScheduleNotify(scheduleTime, dayOfWeek, After5minNotifier());
  }

  Future readGridFromPrefs() async {
    final nagProv = ref.watch(nagProvider);
    final grid = await _prefsManager.readActiveGridFromPrefs(nagProv);
    nagProv.initGrid(grid);
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
        child: buildFutureBlock(dayOfWeek, scheduleTime)
      )
    );
  }

  Widget buildFutureBlock(DayOfWeek dayOfWeek, ScheduleTime scheduleTime){
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: readGridFromPrefs(), 
      builder: (BuildContext context, _){
        final nagProv = ref.watch(nagProvider.notifier);
        return nagProv.getActiveGrid(dayOfWeek: dayOfWeek, scheduleTime: scheduleTime)
        ? Card(
          color: Colors.tealAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          ),
          child: InkWell(
            radius: 4,
            onTap: () {
              nagProv.toggleActiveGrid(dayOfWeek: dayOfWeek, scheduleTime: scheduleTime);
              _deleteScheduleNotify(scheduleTime, dayOfWeek);
              _prefsManager.saveActiveGridToPrefs(nagProv.state);
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
              nagProv.toggleActiveGrid(dayOfWeek: dayOfWeek, scheduleTime: scheduleTime);
              _registerScheduleNotify(scheduleTime, dayOfWeek);
              _prefsManager.saveActiveGridToPrefs(nagProv.state);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.035, horizontal: size.width * 0.02),
              child: const Icon(Icons.notifications_off),
            )
          ),
        );
      }
    );
  }
}
