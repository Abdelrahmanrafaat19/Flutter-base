import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/repositories/notification_permission_repo.dart';

class NotificationPermissionRepoImple implements NotificationPermissionRepo {
  @override
  Future<bool> requestNotificationPermission(BuildContext context) async {
    // Request notification permission
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      print("✅ Notification Permission Granted");
      if (context.mounted) {
        context.go(locationPermissionScreenRoute);
      }
      return true;
    } else if (status.isDenied) {
      print("❌ Notification Permission Denied");
      return false;
    } else if (status.isPermanentlyDenied) {
      print("⚠️ Notification Permission Permanently Denied, Open Settings");
      await openAppSettings();
      if (context.mounted) {
        context.go(locationPermissionScreenRoute);
      }
      return false;
    }
    return false;
  }
}
