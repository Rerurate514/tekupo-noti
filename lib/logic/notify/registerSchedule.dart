import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekupo_noti/models/notifyActiveGrid.dart';

class ScheduleRegister{
  final flnp = FlutterLocalNotificationsPlugin();

  // void scheduledNotificationPerDay({
  //   required timelist,
  // }) async {
  //   var timelist = [
  //     {'hour': 7, 'minutes': 0},
  //     {'hour': 19, 'minutes': 0}
  //   ];

  //   for (int i = 0; i < timelist.length; i++) {
  //     await flnp.zonedSchedule(
  //       i + 1000, // id 重複したら上書き
  //       "薬を飲む時間です!",
  //       '',
  //       _convertTime(int.parse(timelist[i]['hour'].toString()),
  //           int.parse(timelist[i]['minutes'].toString())),
  //       platformChannelSpecifics,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
  //       payload: 'payload!',
  //     );
  //   }
  // }

  void registerScheduleNotify(NotifyActiveGrid grid){

  }

}