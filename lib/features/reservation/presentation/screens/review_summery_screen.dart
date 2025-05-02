import 'package:flutter/material.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/Assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/svg_icons.dart';
import '../providers/use_case_providers.dart';
import '../widgets/data_of_price_row.dart';
import '../widgets/data_of_user_row.dart';
import '../widgets/resturant_data.dart';

class ReviewSummeryScreen extends ConsumerStatefulWidget {
  final int reversationID;
  final int guestCount;

  const ReviewSummeryScreen(
      {super.key, required this.reversationID, required this.guestCount});

  @override
  ConsumerState<ReviewSummeryScreen> createState() =>
      _ReviewSummeryScreenState();
}

class _ReviewSummeryScreenState extends ConsumerState<ReviewSummeryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      ref
          .read(fetchSingle2ReservationUserRestaurantUseCaseProvider.notifier)
          .call(restaurantID: widget.reversationID.toString() ?? "0");
      ref.read(costResUseCaseProvider.notifier).call(
          restaurantID: widget.reversationID.toString() ?? "0",
          guestCount: widget.guestCount);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var reservedRestaurantDataResult =
        ref.watch(fetchSingle2ReservationUserRestaurantUseCaseProvider);
    var getCostResData = ref.watch(costResUseCaseProvider);
    return Scaffold(
      backgroundColor: AppTheme.mainAppBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50.h,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
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
              reservedRestaurantDataResult.state == DataState.SUCCESS
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          ResturantData(
                            name: reservedRestaurantDataResult
                                    .data?[0].rsRestaurant?.name ??
                                "",
                            cusin: reservedRestaurantDataResult
                                    .data?[0].rsRestaurant?.cuisineName ??
                                "",
                            address: reservedRestaurantDataResult
                                    .data?[0].rsRestaurant?.address ??
                                "",
                          ),
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
                          DataOfUserRow(
                            title: "Name",
                            value: reservedRestaurantDataResult
                                    .data?[0].guestName ??
                                "",
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          DataOfUserRow(
                            title: "Email",
                            value: reservedRestaurantDataResult
                                    .data?[0].guestCount
                                    .toString() ??
                                "0",
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          DataOfUserRow(
                            title: "Phone number",
                            value: reservedRestaurantDataResult
                                    .data?[0].guestPhone
                                    .toString() ??
                                "0",
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          DataOfUserRow(
                            title: "Booking Date",
                            value: reservedRestaurantDataResult
                                    .data?[0].createdAt ??
                                "0",
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          DataOfUserRow(
                            title: "Occasion",
                            value:reservedRestaurantDataResult.data?[0].occassion??""
                                    ,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          DataOfUserRow(
                            title: "Number of Guests",
                            value:
                                "${reservedRestaurantDataResult.data?[0].guestPhone.toString() ?? "0"}",
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          const DataOfUserRow(
                            title: "Floor",
                            value: "Roof",
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          const DataOfUserRow(
                            title: "Table Number",
                            value: "5",
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                        ],
                      ),
                    )
                  : reservedRestaurantDataResult.state == DataState.ERROR
                      ? Text(reservedRestaurantDataResult.message ?? "")
                      : Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.codeColorB08A4E,
                          ),
                        ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: getCostResData.state == DataState.SUCCESS
                    ? Column(
                        children: [
                          DataOfPriceRow(
                            title: "Sub Total",
                            value: "\$${getCostResData.data?.subTotal ?? 0}",
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          DataOfPriceRow(
                            title: "Tax",
                            value: "\$${getCostResData.data?.tax ?? 0}",
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
                              Text(
                                "Grand Total",
                                style: AppTheme.style15W400codeColorA3A3A3
                                    .copyWith(
                                        color: AppTheme.codeColor525252,
                                        fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "\$${getCostResData.data?.grandTotal ?? 0}",
                                style: AppTheme.style15W400codeColorA3A3A3
                                    .copyWith(color: AppTheme.codeColorB08A4E),
                              )
                            ],
                          ),
                        ],
                      )
                    : getCostResData.state == DataState.ERROR
                        ? Text(getCostResData.message ?? "")
                        : Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.codeColorB08A4E,
                            ),
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
