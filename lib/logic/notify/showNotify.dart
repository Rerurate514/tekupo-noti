import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

extension ShowNotifyFlnp on FlutterLocalNotificationsPlugin{
  getScheduled() async {
    final List<PendingNotificationRequest> pendingNotificationRequests = await this.pendingNotificationRequests();
    for (var pendingNotificationRequest in pendingNotificationRequests) {
      print('予約済みの通知: [id: ${pendingNotificationRequest.id}, title: ${pendingNotificationRequest.title}, body: ${pendingNotificationRequest.body}, payload: ${pendingNotificationRequest.payload}]');
    }
  }
}

extension ShowNotifyAwesome on AwesomeNotifications {
  getScheduled() async {
    final List<NotificationModel> activeSchedules = await AwesomeNotifications().listScheduledNotifications();
    for(var schedule in activeSchedules){
      print('予約済みの通知: [id: ${schedule.content?.id}, title: ${schedule.content?.title}, body: ${schedule.content?.body}, payload: ${schedule.content?.payload}]');
    }
  }
}
