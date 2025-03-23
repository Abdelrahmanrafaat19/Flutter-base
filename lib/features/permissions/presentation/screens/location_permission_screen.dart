import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/app_button.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

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
            SizedBox(
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
                onPress: () {}),
            SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Enter Location Manually",
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
}
