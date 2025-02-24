import 'package:flutter/material.dart';

abstract class AddressPermissionRepo {
  Future<void> requestLocationPermission(BuildContext context);
}
