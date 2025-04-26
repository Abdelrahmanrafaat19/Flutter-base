import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/reservation/data/models/rs_restaurant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/Assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/svg_icons.dart';
import '../../domain/use_case/fetch_single_reservation_use_case.dart';
import '../providers/use_case_providers.dart';
import '../widgets/data_table_book_success_column.dart';
import '../widgets/resturant_data_booking_details.dart';

class BookingDetails extends ConsumerStatefulWidget {
  final String bookindID;

  const BookingDetails(this.bookindID, {super.key});

  @override
  ConsumerState<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends ConsumerState<BookingDetails> {
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      ref
          .read(fetchSingleReservationUserRestaurantUseCaseProvider.notifier)
          .call(restaurantID: widget.bookindID);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var singleReservedRestaurantDataResult =
        ref.watch(fetchSingleReservationUserRestaurantUseCaseProvider);

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
          'Book a Table',
          style:
              AppTheme.style20BlackBold.copyWith(fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppTheme.mainAppBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        width: double.infinity,
        height: double.infinity,
        child: (singleReservedRestaurantDataResult.state == DataState.SUCCESS)
            ? Skeletonizer(
                enabled: singleReservedRestaurantDataResult.state ==
                    DataState.LOADING,
                child: singleReservedRestaurantDataResult.data != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: AppTheme.whiteColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                ResturantDataBookingDetails(
                                  restaurant: singleReservedRestaurantDataResult
                                          .data![0].rsRestaurant ??
                                      RsRestaurant(),
                                  status: singleReservedRestaurantDataResult
                                          .data![0].status ??
                                      "",
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Divider(
                                  height: 2.h,
                                  color: AppTheme.colorCodeEAEAEA,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 2 / 1,
                                            crossAxisSpacing: 100.w,
                                            mainAxisSpacing: 20.h),
                                    itemCount: titleListData.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      String date = getDate(
                                          singleReservedRestaurantDataResult
                                                  .data?[0].createdAt ??
                                              "");
                                      String time = getTime(
                                          singleReservedRestaurantDataResult
                                                  .data?[0].createdAt ??
                                              "");
                                      List<String?> valueListData = [
                                        singleReservedRestaurantDataResult
                                            .data?[0].guestName,
                                        date,
                                        time,
                                        "-",
                                        singleReservedRestaurantDataResult
                                                .data?[0].guestCount
                                                .toString() ??
                                            "",
                                        "F-02",
                                        "Roof",
                                        "0259"
                                      ];
                                      return DataTableBookSuccessColumn(
                                        title: titleListData[index],
                                        value: valueListData[index]!,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          singleReservedRestaurantDataResult.data![0].status ==
                                  "ACTIVITE"
                              ? Text(
                                  "Cancel  your Booking?",
                                  style: AppTheme.styleSize16Weidth500RedColor,
                                )
                              : const SizedBox(),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                singleReservedRestaurantDataResult
                                            .data![0].status !=
                                        "CANCELLED"
                                    ? Expanded(
                                        child: AppButton(
                                          outlined: true,
                                          height: defaultButtonHeight,
                                          backColor: AppTheme.codeColorB08A4E,
                                          text: "Navigate",
                                          onPress: () {},
                                        ),
                                      )
                                    : SizedBox(),
                                singleReservedRestaurantDataResult
                                            .data![0].status !=
                                        "CANCELLED"
                                    ? SizedBox(width: 16.w)
                                    : const SizedBox(), // space between buttons
                                Expanded(
                                  child: AppButton(
                                    height: defaultButtonHeight,
                                    child: Text(
                                      singleReservedRestaurantDataResult
                                                  .data![0].status ==
                                              "ACTIVITE"
                                          ? "You Have Arrived?"
                                          : singleReservedRestaurantDataResult
                                                      .data![0].status ==
                                                  "CONFIRMED"
                                              ? "Write Review"
                                              : "Re-Book",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "cairepro",
                                        color: AppTheme.whiteColor,
                                      ),
                                    ),
                                    backColor: AppTheme.codeColorB08A4E,
                                    onPress: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Text("Not any Data",
                        style: AppTheme.style20BlackBold
                            .copyWith(fontWeight: FontWeight.w700)))
            :(singleReservedRestaurantDataResult.state == DataState.ERROR)? Center(
                child: Text(
                    singleReservedRestaurantDataResult.message ??
                        "Check Your NetWork",
                    style: AppTheme.style20BlackBold
                        .copyWith(fontWeight: FontWeight.w700)),
              ):SizedBox(),
      ),
    );
  }

  String getDate(String date) {
    return DateFormat('MMM dd, yyyy').format(DateTime.parse(date));
  }

  String getTime(String date) {
    return DateFormat('h:mm a').format(DateTime.parse(date));
  }
}
