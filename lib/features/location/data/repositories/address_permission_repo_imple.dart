import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/features/location/domain/repositories/address_permission_repo.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class AddressPermissionRepoImple implements AddressPermissionRepo {
  @override
  Future<void> requestLocationPermission(context) async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission granted")),
      );
      context.go(notificationPermissionScreenRoute);
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
