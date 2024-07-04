import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';
import 'package:tekupo_noti/models/notity.dart';
import 'package:tekupo_noti/models/time.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_test/flutter_test.dart';

class ScheduleRegistry{
  final _flnp = FlutterLocalNotificationsPlugin();

  void registerScheduleNotify(ScheduleTime scheduleTime, DayOfWeek dayOfWeek, Notity notify) async {
    print("${dayOfWeek.jpStr}曜日の${scheduleTime.num}時間目が登録されました。[${scheduleTime.getTime[START_LESSON_TIME]!.hour} ~ ${scheduleTime.getTime[END_LESSON_TIME]!.hour}]");
    
    final tzTime = _convertTime(notify.getNotifyTime(scheduleTime), dayOfWeek);
    
    await _flnp.zonedSchedule(
      "$scheduleTime$dayOfWeek$notify".hashCode, 
      notify.title, 
      notify.bodyText, 
      tzTime, 
      NotificationDetails(
        android: AndroidNotificationDetails(
          notify.title,
          notify.bodyText,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ), 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: "${scheduleTime.num} of ${dayOfWeek.jpStr} : $notify => ${tzTime}",
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
    );
  }

  tz.TZDateTime _convertTime(Time time, DayOfWeek dayOfWeek) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + _getDiffDate(dayOfWeek),
      time.hour,
      time.minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  int _getDiffDate(DayOfWeek dayOfWeek){
    final DateTime now = DateTime.now();

    int dif = dayOfWeek.index - (now.day);
    if(dif < 0) dif = 7 + dif;
    
    return dif;
  }
}

void main(){
  test("calc-diff", () {
    int diff = ScheduleRegistry()._getDiffDate(DayOfWeek.TURSDAY);
    print(diff);
  });
}
