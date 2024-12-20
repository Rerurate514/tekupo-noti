import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';
import 'package:tekupo_noti/models/notity.dart';

class ScheduleDeleter{
  final _flnp = FlutterLocalNotificationsPlugin();

  void deleteScheduleNotify(ScheduleTime scheduleTime, DayOfWeek dayOfWeek, Notity notify) async {
    await _flnp.cancel("$scheduleTime$dayOfWeek$notify".hashCode, tag: "$scheduleTime$dayOfWeek$notify");
  }

  void deleteAllScheduleNotify() async {
    await _flnp.cancelAll();
  }
}
