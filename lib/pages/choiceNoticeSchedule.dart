import 'package:flutter/material.dart';
import 'package:tekupo_noti/widgets/appInfo.dart';
import 'package:tekupo_noti/widgets/scheduleGrid.dart';
import 'package:tekupo_noti/widgets/weekLabel.dart';

class ChoiceNoticeTimePage extends StatefulWidget {
  const ChoiceNoticeTimePage({super.key});

  @override
  _ChoiceNoticeSchedulePageState createState() => _ChoiceNoticeSchedulePageState();
}

class _ChoiceNoticeSchedulePageState extends State<ChoiceNoticeTimePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ScheduleGrid(),
          SizedBox(height: size.height * 0.01),
          AppInfo()
        ],
      )
    );
  }
}