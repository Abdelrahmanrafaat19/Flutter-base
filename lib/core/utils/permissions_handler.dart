import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler{

  static Future<bool> checkLocationPermission() async {
    // Check the status of the location permission
    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // Request the permission
      if (await Permission.location.request().isGranted) {
        return true;
      } else {
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
      // Direct the user to app settings to enable permissions
    }else {
      return false ;
    }
  }

}