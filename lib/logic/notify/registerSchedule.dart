import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';
import 'package:tekupo_noti/logic/notify/notifyActionBtnsConfig.dart';
import 'package:tekupo_noti/models/notity.dart';
import 'package:tekupo_noti/models/time.dart';
import 'package:timezone/timezone.dart' as tz;


class ScheduleRegistry{
  final _anRegistry = _AnRegistry();
  final _flnpRegistry = _FlnpRegistry();

  void registerScheduleNotify(
    ScheduleTime scheduleTime, 
    DayOfWeek dayOfWeek,
    Notity notify,
    [NotifyActionBtnsConfig? config]
  ) async {
    //_anRegistry.registerScheduleNotify(scheduleTime, dayOfWeek, notify, config!);
    _flnpRegistry.registerScheduleNotify(scheduleTime, dayOfWeek, notify);
  }
}

class TZDateConverter{
  tz.TZDateTime convertTime(Time time, DayOfWeek dayOfWeek) {
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

    int dif = dayOfWeek.index - (now.day % 7 + 1);
    if(dif < 0) dif = 7 + dif;
    
    return dif;
  }
}

class _FlnpRegistry{
  final _flnp = FlutterLocalNotificationsPlugin();
  final _tzConverter = TZDateConverter();

  void registerScheduleNotify(ScheduleTime scheduleTime, DayOfWeek dayOfWeek, Notity notify) async {
    final tzTime = _tzConverter.convertTime(notify.getNotifyTime(scheduleTime), dayOfWeek);
      
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
}

class _AnRegistry{
  final _an = AwesomeNotifications();
  final _tzConverter = TZDateConverter();

  void registerScheduleNotify(
    ScheduleTime scheduleTime, 
    DayOfWeek dayOfWeek,
    Notity notify,
    NotifyActionBtnsConfig config
  ) async {
    print("${dayOfWeek.jpStr}曜日の${scheduleTime.num}時間目が登録されました。[${scheduleTime.getTime[START_LESSON_TIME]!.hour} ~ ${scheduleTime.getTime[END_LESSON_TIME]!.hour}]");
    final tzTime = _tzConverter.convertTime(notify.getNotifyTime(scheduleTime), dayOfWeek);

    _an.createNotification(
      content: NotificationContent(
        id: "$scheduleTime$dayOfWeek$notify".hashCode, 
        channelKey: "reminder",
        title: notify.title, 
        body: notify.bodyText, 
      ),
      actionButtons: config.buildBtns(),
      schedule: NotificationCalendar(
        weekday: dayOfWeek.index,
        hour: tzTime.hour,
        minute: tzTime.minute,
        timeZone: "Japan/Tokyo",
        repeats: true,
        allowWhileIdle: true
      )
    );
  }
}
