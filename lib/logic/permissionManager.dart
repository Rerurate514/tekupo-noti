import 'package:permission_handler/permission_handler.dart';

class PermissionManager{
  Future<void> requsestNotifyPermission() async {
    PermissionStatus status = await Permission.notification.request();
  }
}
