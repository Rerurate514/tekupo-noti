import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flnp = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    _initFlnp();
  }

  Future<void> _initFlnp() async {
    AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, 
      iOS: initializationSettingsIOS
    );
    await _flnp.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {});
  }
}
