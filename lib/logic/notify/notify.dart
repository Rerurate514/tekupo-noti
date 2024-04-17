import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification{
  final FLNP = FlutterLocalNotificationsPlugin();
  final bodyText = '出席ボタンを押してください！';

  Future<void> notifyNotifyBefore10min() {
    return FLNP.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    ).then((_) => FLNP.show(0, '授業開始10分前です!', bodyText, const NotificationDetails(
      android: AndroidNotificationDetails(
        'notifyBefore10min',
        '授業開始10分前の通知',
        importance: Importance.high,
        priority: Priority.high,
      ),
    )));
  }

    Future<void> notifyNotifyStartLesson() {
      return FLNP.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      ).then((_) => FLNP.show(0, '授業が開始しました!', bodyText, const NotificationDetails(
        android: AndroidNotificationDetails(
          'notifyStartSub',
          '授業開始時の通知',
          importance: Importance.high,
          priority: Priority.high,
        ),
      )));
  }

  Future<void> notifyNotifyAfter5min() {
    return FLNP.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    ).then((_) => FLNP.show(0, '授業開始5分後です!', bodyText, const NotificationDetails(
      android: AndroidNotificationDetails(
        'notifyAfter5min',
        '授業開始5分後の通知',
        importance: Importance.high,
        priority: Priority.high,
      ),
    )));
  }
}