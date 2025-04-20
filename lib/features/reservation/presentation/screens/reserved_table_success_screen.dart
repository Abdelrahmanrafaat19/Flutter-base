import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/data_table_book_success_column.dart';

class ReservedTableSuccessScreen extends StatelessWidget {
  ReservedTableSuccessScreen({super.key});

  List<String> titleListData = [
    "Name",
    "Date",
    "Time",
    "Duration",
    "No.of Guests",
    "Table Number",
    "Floor",
    "Booking no."
  ];
  List<String> valueListData = [
    "wael Wlbialy",
    "Feb 03,2025",
    "10:00Am",
    "-",
    "04",
    "F-02",
    "Roof",
    "0259"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainAppBackgroundColor,
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
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.whiteColor,
                  border: Border.all(color: AppTheme.colorCodeEAEAEA),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Image.asset(
                      reservedIcon,
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Your table is reserved!",
                      style: AppTheme.style20W700codeColor171717,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Divider(
                      height: 2.h,
                      color: AppTheme.colorCodeEAEAEA,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      width: double.infinity,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 1.4,
                            crossAxisSpacing: 100.w,
                            mainAxisSpacing: 20.h),
                        itemCount: titleListData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return DataTableBookSuccessColumn(
                            title: titleListData[index],
                            value: valueListData[index],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AppButton(
                  width: double.infinity,
                  height: defaultButtonHeight,
                  backColor: AppTheme.codeColorB08A4E,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SVGIcons.localSVG(
                        carIcon,
                        height: 24.h,
                        width: 24.w,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        "Navigate to Restaurant",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: "cairepro",
                        ),
                      ),
                    ],
                  ),
                  onPress: () {},
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AppButton(
                  outlined: true,
                  width: double.infinity,
                  height: defaultButtonHeight,
                  backColor: AppTheme.codeColorB08A4E,
                  text: "View Booking",
                  onPress: () {},
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
*
*
*   Image.asset(
              "assets/images/notification_access.gif",
              width: 180,
              height: 180,
            ),*/
