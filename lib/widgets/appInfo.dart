import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekupo_noti/logic/notify/deleteSchedule.dart';
import 'package:tekupo_noti/logic/notify/showNotify.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekupo_noti/logic/sharedPrefsManager.dart';
import 'package:tekupo_noti/providers/gridProvider.dart';

class AppInfo extends ConsumerStatefulWidget {
  const AppInfo({super.key});

  @override
  AppinfoState createState() => AppinfoState();
}

class AppinfoState extends ConsumerState<AppInfo> {
  final SharedPrefsManager _prefsManager = SharedPrefsManager();

  bool _isNoticeBefore10min = true;
  bool _isNoticeStartSub = true;
  bool _isNoticeAfter5min = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "通知の時間",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: size.width * 0.1),
        Column(
          children: [
            buildCard(context, "開始10分前", _isNoticeBefore10min),
            buildCard(context, "始まった時間", _isNoticeStartSub),
            buildCard(context, "開始5分後", _isNoticeAfter5min),
          ],
        ),
        Column(
          children: [
            buildButton(
              context, 
              Icons.show_chart, 
              () async {
                await FlutterLocalNotificationsPlugin().getScheduled();
              }
            ),
            buildButton(
              context, 
              Icons.delete, 
              () async {
                final nagProv = ref.watch(nagProvider.notifier);
                ScheduleDeleter().deleteAllScheduleNotify();
                nagProv.initGrid();
                _prefsManager.saveActiveGridToPrefs(nagProv.state);
              }
            )
          ],
        )
      ],
    );
  }

  Widget buildCard(BuildContext context, String discription, bool isActive){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.35,
      height: size.height * 0.053,
      child: isActive
        ? Card(
          color: Colors.white,
          elevation: 1,
          child: Row(
            children: [
              SizedBox(width: size.width * 0.01),
              const Icon(
                Icons.notifications,
                size: 25,
              ),
              SizedBox(width: size.width * 0.02),
              Text(
                discription,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
        : Card(
        color: Colors.redAccent,
        elevation: 1,
        child: Row(
          children: [
            SizedBox(width: size.width * 0.01),
            const Icon(
              Icons.notifications_off,
              size: 25,
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              discription,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, IconData icon, Function() callback){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.25,
      height: size.height * 0.053,
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: () {
            callback();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: size.width * 0.01),
              Icon(icon),
              SizedBox(width: size.width * 0.02),
            ],
          ),
        )
      )
    );
  }
}
