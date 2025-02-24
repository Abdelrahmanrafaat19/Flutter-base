import 'package:permission_handler/permission_handler.dart';

import '../../domain/repositories/notification_permission_repo.dart';

class NotificationPermissionRepoImple implements NotificationPermissionRepo {
  @override
  Future<bool> requestNotificationPermission() async {
    // Request notification permission
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      print("✅ Notification Permission Granted");
      return true;
    } else if (status.isDenied) {
      print("❌ Notification Permission Denied");
      return false;
    } else if (status.isPermanentlyDenied) {
      print("⚠️ Notification Permission Permanently Denied, Open Settings");
      await openAppSettings();
      return false;
    }
    return false;
  }
}
