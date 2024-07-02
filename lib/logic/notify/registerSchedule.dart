import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';
import 'package:tekupo_noti/models/notity.dart';
import 'package:tekupo_noti/models/time.dart';
import 'package:timezone/timezone.dart' as tz;

class ScheduleRegistry{
  final _flnp = FlutterLocalNotificationsPlugin();

  void registerScheduleNotify(ScheduleTime scheduleTime, DayOfWeek dayOfWeek, Notity notify) async {
    print("${dayOfWeek.jpStr}曜日の${scheduleTime.num}時間目が登録されました。[${scheduleTime.getTime[START_LESSON_TIME]!.hour} ~ ${scheduleTime.getTime[END_LESSON_TIME]!.hour}]");
    await _flnp.zonedSchedule(
      "$scheduleTime$dayOfWeek$notify".hashCode, 
      notify.title, 
      notify.bodyText, 
      _convertTime(notify.getNotifyTime(scheduleTime)), 
      NotificationDetails(
        android: AndroidNotificationDetails(
          notify.title,
          notify.bodyText,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ), 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: "$scheduleTime$dayOfWeek$notify"
    );
  }

  tz.TZDateTime _convertTime(Time time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }
}