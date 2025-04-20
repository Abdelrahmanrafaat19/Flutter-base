import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/Assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/svg_icons.dart';
import '../widgets/data_of_price_row.dart';
import '../widgets/data_of_user_row.dart';
import '../widgets/resturant_data.dart';

class ReviewSummeryScreen extends StatelessWidget {
  const ReviewSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.mainAppBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50.h,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_sharp,
              color: AppTheme.colorCode171717,
              size: 24.sp,
            )),
        title: Text(
          'Review Summary',
          style:
              AppTheme.style20BlackBold.copyWith(fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppTheme.mainAppBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    const ResturantData(),
                    SizedBox(
                      height: 12.h,
                    ),
                    Divider(
                      height: 2.h,
                      color: AppTheme.colorCodeEAEAEA,
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                  const   DataOfUserRow(
                      title: "Name",
                      value: "AbdelrahmanShoaib",
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const   DataOfUserRow(
                      title: "Email",
                      value: "AbdelrahmanShoaib@gmail.com",
                    ),
                    SizedBox(
                      height: 24.h,
                    ), const   DataOfUserRow(
                      title: "Phone number",
                      value: "+201063103655",
                    ),
                    SizedBox(
                      height: 24.h,
                    ), const   DataOfUserRow(
                      title: "Booking Date",
                      value: "Feb 03, 2025 | 10:00 AM",
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const   DataOfUserRow(
                      title: "Occasion",
                      value: "BirthDay",
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const   DataOfUserRow(
                      title: "Number of Guests",
                      value: "4 Adults",
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const   DataOfUserRow(
                      title: "Floor",
                      value: "Roof",
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    const   DataOfUserRow(
                      title: "Table Number",
                      value: "5",
                    ),
                    SizedBox(
                      height: 16.h,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    DataOfPriceRow(
                      title:"Sub Total" ,
                      value: "\$500",
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    DataOfPriceRow(
                      title:"Tax" ,
                      value: "\$50",
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Divider(
                      height: 2.h,
                      color: AppTheme.colorCodeEAEAEA,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Grand Total", style:  AppTheme.style15W400codeColorA3A3A3.copyWith(color: AppTheme.codeColor525252,fontWeight: FontWeight.w700),),
                        Text("\$550", style:  AppTheme.style15W400codeColorA3A3A3.copyWith(color: AppTheme.codeColorB08A4E),)
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  width: double.infinity,
                  height: defaultButtonHeight,
                  backColor: AppTheme.codeColorB08A4E,
                  text: "Pay and Reserve",
                  onPress: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
