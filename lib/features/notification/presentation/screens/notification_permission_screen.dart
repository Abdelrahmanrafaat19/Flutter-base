import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/app_button.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

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
              "assets/images/notification_access.gif",
              width: 180,
              height: 180,
            ),
            SizedBox(
              height: 55,
            ),
            Text(
              "Enable Notification Access",
              style: AppTheme.fontStyle24W70022252BColor,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Enable notification to receive real-timeupdates",
              textAlign: TextAlign.center,
              style: AppTheme.style14W500code8088A4Color,
            ),
            SizedBox(
              height: 50,
            ),
            AppButton(
                width: double.infinity,
                height: defaultButtonHeight,
                text: "Allow Notification",
                backColor: AppTheme.mainAppColor,
                onPress: () {}),
            SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Maybe Later",
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
