import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';

class ReservedTableSuccessCodeScreen extends StatelessWidget {
  const ReservedTableSuccessCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 50.h,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_sharp,
              color: AppTheme.colorCode171717,
              size: 24.sp,
            )),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Help me",
              style: AppTheme.style15W500codeColorB08A4E,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          SVGIcons.localSVG(
            helpMeIcon,
            width: 20.w,
            height: 20.h,
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 130.h,
            ),
            Image.asset(
              codeSuccessIcon,
              width: 180.w,
              height: 180.h,
            ),
            SizedBox(
              height: 32.h,
            ),
            Text(
              "0259",
              style: AppTheme.style48W700codeColor171717,
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "You Have Arrived?",
              style: AppTheme.style48W700codeColor171717.copyWith(
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "Edit subtext",
              style: AppTheme.style14W400codeColor737373,
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      outlined: true,
                      height: defaultButtonHeight,
                      backColor: AppTheme.codeColorB08A4E,
                      text: "Go to Home",
                      onPress: () {},
                    ),
                  ),
                  SizedBox(width: 16.w), // space between buttons
                  Expanded(
                    child: AppButton(
                      height: defaultButtonHeight,
                      backColor: AppTheme.codeColorB08A4E,
                      text: "Start ordering",
                      onPress: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
