import 'package:flutter/cupertino.dart';

abstract class NotificationPermissionRepo {
  Future<bool> requestNotificationPermission(BuildContext context);
}
