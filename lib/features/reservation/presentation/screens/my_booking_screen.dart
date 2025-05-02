import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_base/features/reservation/domain/entities/fetch_user_reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/models/StateModel.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/paginated_listview.dart';
import '../../data/models/reserved_restaurant_model.dart';
import '../../data/models/rs_restaurant.dart';
import '../providers/use_case_providers.dart';
import '../widgets/booked_resturant_data.dart';

class MyBookingScreen extends ConsumerStatefulWidget {
  const MyBookingScreen({super.key});

  @override
  ConsumerState<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends ConsumerState<MyBookingScreen> {
  List<ReservedRestaurantEntity> reservedRestaurantist = [];
  int page = 0;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      reservedRestaurantist.clear();
      var reservedRestaurantList =
          ref.read(fetchReservedUserRestaurantUseCaseProvider);
      reservedRestaurantist = reservedRestaurantList.data ?? [];
      fetchReservedRestaurants(page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var reservedRestaurantDataResult =
        ref.watch(fetchReservedUserRestaurantUseCaseProvider);
    var reminderTriggerResult = ref.watch(reminderTriggerUseCaseProvider);
    return Scaffold(
      backgroundColor: AppTheme.mainAppBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Text(
          'My Booking',
          style:
              AppTheme.style20BlackBold.copyWith(fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppTheme.mainAppBackgroundColor,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Expanded(
          child: !(reservedRestaurantDataResult.data?.isEmpty == true &&
                  reservedRestaurantDataResult.state == DataState.SUCCESS)
              ? PaginatedListView<ReservedRestaurantEntity>(
                  dataList: reservedRestaurantDataResult.data ??
                      [
                        ReservedRestaurantEntity(),
                        ReservedRestaurantEntity(),
                        ReservedRestaurantEntity(),
                        ReservedRestaurantEntity(),
                        ReservedRestaurantEntity(),
                      ],
                  scrollPhysics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  paginated: true,
                  pageLoading: reservedRestaurantDataResult.state ==
                      DataState.MORE_LOADING,
                  onBottomReached: () {
                    fetchReservedRestaurants(++page);
                  },
                  builder: (item) {
                    final _controller =
                        ValueNotifier<bool>(item.reminder ?? false);
                    String date = getDate(item.createdAt ?? "");
                    String time = getTime(item.createdAt ?? "");
                    return Skeletonizer(
                        enabled: reservedRestaurantDataResult.state ==
                            DataState.LOADING,
                        child: GestureDetector(
                          onTap: () {
                            context.push(bookingDetailsRoute, extra: {
                              BOOKING_ID: item.rsRestaurant!.id.toString(),
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                                color: AppTheme.whiteColor,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppTheme.colorCodeEAEAEA,
                                  width: 1.w,
                                )),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Remind Me",
                                              style: AppTheme
                                                  .styleSize13Weidth400color737373,
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            AdvancedSwitch(
                                              controller: _controller,
                                              activeColor:
                                                  AppTheme.colorCodeEAEAEA,
                                              initialValue:
                                                  item.reminder ?? false,
                                              inactiveColor:
                                                  AppTheme.colorCodeEAEAEA,
                                              width: 41.w,
                                              height: 20.h,
                                              borderRadius:
                                                  BorderRadius.circular(24.r),
                                              onChanged: (value) {
                                                print("SWITCH VALUE $value");
                                                ref
                                                    .read(
                                                        reminderTriggerUseCaseProvider
                                                            .notifier)
                                                    .call(
                                                        restaurantID:
                                                            item.id.toString(),
                                                        flag: value);
                                                if (reminderTriggerResult
                                                        .state ==
                                                    DataState.SUCCESS) {
                                                  _controller.value = value;
                                                } else if (reminderTriggerResult
                                                        .state ==
                                                    DataState.ERROR) {
                                                  _controller.value =
                                                      item.reminder ?? false;
                                                }
                                              },
                                              thumb:
                                                  ValueListenableBuilder<bool>(
                                                valueListenable: _controller,
                                                builder: (_, value, __) {
                                                  return Container(
                                                    width: 24.w,
                                                    height: 24.h,
                                                    decoration: BoxDecoration(
                                                      color: AppTheme
                                                          .colorCodeD9BA8C,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.red
                                                              .withOpacity(0.1),
                                                          blurRadius: 3,
                                                          offset: const Offset(
                                                              0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          date,
                                          style: AppTheme
                                              .styleSize13Weidth400color737373,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 32.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: item.status == "ACTIVITE"
                                            ? AppTheme.lightGreen2
                                            : item.status == "CONFIRMED"
                                                ? const Color(0xffF5F5F5)
                                                : AppTheme.lightRed,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Text(
                                        item.status.toString(),
                                        style: TextStyle(
                                          color: item.status == "ACTIVITE"
                                              ? AppTheme.greenColor
                                              : item.status == "CONFIRMED"
                                                  ? AppTheme.codeColor525252
                                                  : AppTheme.redColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "cairepro",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                BookedResturantData(
                                  rsRestaurant:
                                      item.rsRestaurant ?? RsRestaurant(),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 42.h,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AppButton(
                                          outlined: true,
                                          height: defaultButtonHeight,
                                          backColor: AppTheme.codeColorB08A4E,
                                          text: "Navigate",
                                          onPress: () {},
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      // space between buttons
                                      Expanded(
                                        child: AppButton(
                                          height: defaultButtonHeight,
                                          backColor: AppTheme.codeColorB08A4E,
                                          onPress: () {},
                                          child: Text(
                                            item.status == "ACTIVITE"
                                                ? "You Have Arrived?"
                                                : item.status == "CONFIRMED"
                                                    ? "Write Review"
                                                    : "Re-Book",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "cairepro",
                                              color: AppTheme.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                )
              : Center(child: Text("Check YourData")),
        ),
      ),
    );

  }

  void fetchReservedRestaurants(int page) {
    ref.read(fetchReservedUserRestaurantUseCaseProvider.notifier).call(
          page: page.toString(),
          size: 10.toString(),
        );
  }

  String getDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('MMM dd, yyyy').format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  String getTime(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('h:mm a').format(parsedDate);
    } catch (e) {
      return "Invalid Time";
    }
  }
}
/*
*  ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppTheme.colorCodeEAEAEA,
                    width: 1.w,
                  )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Remind Me",
                                style: AppTheme.styleSize13Weidth400color737373,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              AdvancedSwitch(
                                controller: _controller,
                                activeColor: AppTheme.colorCodeEAEAEA,
                                initialValue: true,
                                inactiveColor: AppTheme.colorCodeEAEAEA,
                                width: 41.w,
                                height: 20.h,
                                borderRadius: BorderRadius.circular(24.r),
                                onChanged: (value) {},
                                thumb: ValueListenableBuilder<bool>(
                                  valueListenable: _controller,
                                  builder: (_, value, __) {
                                    return Container(
                                      width: 24.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                        color: AppTheme.colorCodeD9BA8C,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.red.withOpacity(0.1),
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Feb 05, 2025 - 15:00",
                            style: AppTheme.styleSize13Weidth400color737373,
                          ),
                        ],
                      ),
                      Container(

                        height: 32.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:index%2==0? AppTheme.lightGreen2:AppTheme.lightRed,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          index%2==0?"Active":"Canceled",
                          style: TextStyle(
                            color:index%2==0? AppTheme.greenColor:AppTheme.redColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "cairepro",
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  BookedResturantData(),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 42.h,

                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            outlined: true,
                            height: defaultButtonHeight,
                            backColor: AppTheme.codeColorB08A4E,
                            text: "Navigate",
                            onPress: () {},
                          ),
                        ),
                        SizedBox(width: 16.w), // space between buttons
                        Expanded(
                          child: AppButton(
                            height: defaultButtonHeight,
                            child:  Text(
                              index%2==0?  "You Have Arrived?":"ReBook",
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
              ),
            );
          },
          itemCount: 5,
        )*/
