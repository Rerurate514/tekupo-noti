import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:tekupo_noti/enums/dayOfWeek.dart';
import 'package:tekupo_noti/enums/scheduleTime.dart';

class NotifyActionBtnsConfig {
  final ScheduleTime scheduleTime;
  final DayOfWeek dayOfWeek;

  NotifyActionBtnsConfig(this.scheduleTime, this.dayOfWeek);

  List<NotificationActionButton> buildBtns(){
    List<NotificationActionButton> btnList = [
      NotificationActionButton(
        key: "stopNotify", 
        label: "この講義の通知を止める。"
      )
    ];

    return btnList;
  }
}
