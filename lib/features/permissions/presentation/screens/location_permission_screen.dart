import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/app_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../location/data/repositories/address_permission_repo_imple.dart';
import '../../../location/domain/address_storage.dart';
import '../../../location/presentaion/providers/use_cases_provider.dart';
import '../../data/model/address_model.dart';

class LocationPermissionScreen extends ConsumerStatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  ConsumerState<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState
    extends ConsumerState<LocationPermissionScreen> {
  void _onSelectAddress(Address address) {
    AddressStorage.saveUserCurrentLocation(address);
    updateUserLocation(address);
    context.pop(true);
  }

  // In your widget where you call this method:
  void _getLocationAndNavigate(context) async {
    try {
      final address = await AddressPermissionRepoImple.getCurrentLocation(context);
      // Now navigate after getting the location
     context.push(notificationPermissionScreenRoute);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*  SVGIcons.localSVG(
              "assets/images/location_icon.svg",
              width: 180,
              height: 180,
            ) */
            Image.asset(
              "assets/images/location_image.gif",
              width: 180,
              height: 180,
            ),
         const   SizedBox(
              height: 55,
            ),
            Text(
              "What is Your Location?",
              style: AppTheme.fontStyle24W70022252BColor,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "We need your location to show availablenearby restaurant",
              textAlign: TextAlign.center,
              style: AppTheme.style14W500code8088A4Color,
            ),
            SizedBox(
              height: 50,
            ),
            AppButton(
              width: double.infinity,
              height: defaultButtonHeight,
              text: "Allow Location Access",
              backColor: AppTheme.mainAppColor,
              onPress: () async {
                Address? currentAddress =
                    await AddressPermissionRepoImple().requestLocationPermission(context);
                print(currentAddress?.placeName);
                _onSelectAddress(currentAddress!);
                _getLocationAndNavigate(context);
                // context.push(notificationPermissionScreenRoute);
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {
                context.go(mainScreenRoute);
              },
              child: Text(
                "May be later",
                style: TextStyle(
                    color: AppTheme.mainAppColor,
                    fontSize: 14,
                    fontFamily: "cairepro"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateUserLocation(Address address) {
    ref
        .read(updateUserLocationStateNotifierProvider.notifier)
        .updateUserLocation(address);
  }
}
