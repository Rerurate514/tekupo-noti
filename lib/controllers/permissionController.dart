import 'dart:html';

import 'package:permission_handler/permission_handler.dart';

class PermissionController{
  Future<void> requsestNotifyPermission() async {
    PermissionStatus status = await Permission.notification.request();
  }
}