import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/models/StateModel.dart';
import '../../../../core/widgets/app_button.dart';
import '../../data/models/meal_time_slot.dart';
import '../providers/use_case_providers.dart';
import '../widgets/date_container.dart';
import '../widgets/guest_container.dart';

class BookTableScreen extends ConsumerStatefulWidget {
  final dynamic resID;

  const BookTableScreen({super.key, required this.resID});

  @override
  ConsumerState<BookTableScreen> createState() => _BookTableScreenState();
}

class _BookTableScreenState extends ConsumerState<BookTableScreen> {
  int numberOfGuest = 0;
  int isSelected = 1;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final List<DateTime> days = [];
  String? myDate;
  final dates = ["1", "2", "3", "4", "5"];
  String? selectedTime;
  int? selectedIndex;

  List<DateTime> generateInitialDays() {
    DateTime now = DateTime.now();
    return List.generate(5, (index) {
      days.add(now.subtract(Duration(days: 1 - index)));
      return now.subtract(Duration(days: 1 - index));
    });
  }

  List<DateTime> generateDaysAroundSelected(DateTime selectedDate) {
    days.clear();
    return List.generate(5, (index) {
      days.add(selectedDate.subtract(Duration(days: 1 - index)));
      return selectedDate.subtract(Duration(days: 1 - index));
    });
  }

  @override
  void initState() {
    generateDaysAroundSelected(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      ref
          .read(availableMealTimeUseCaseProvider.notifier)
          .call(restaurantID: widget.resID.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var availblTimeMeleTimeResult = ref.watch(availableMealTimeUseCaseProvider);

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
        actions: [
          Container(
            width: 40.w,
            height: 36.h,
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 7.h,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppTheme.lightBrown,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Text('B', style: TextStyle(color: Colors.brown)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GuestContainer(
                      increment: () {
                        numberOfGuest++;
                        setState(() {});
                      },
                      decrement: () {
                        numberOfGuest--;
                        setState(() {});
                      },
                      guestCounter: numberOfGuest,
                    ),
                    SizedBox(height: 24.h),
                    DateContainer(
                      onTap: () {
                        print("This is Select Date $_selectedDay");
                      },
                      dates: dates,
                      days: days,
                      selectedDay: _selectedDay,
                      focusedDay: _focusedDay,
                      onDateSelected: (selectedDate) {
                        setState(() {
                          _selectedDay = selectedDate;

                          myDate = DateFormat('yyyy-MM-dd')
                              .format(_selectedDay ?? DateTime.now());

                          print(myDate);
                        });
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        print(dates[isSelected]);
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        Navigator.of(context).pop();

                        generateDaysAroundSelected(selectedDay);

                        setState(() {});
                      },
                    ),
                    SizedBox(height: 24.h),
                    _buildTimeSection(
                        mealTimeBreakFast: availblTimeMeleTimeResult
                            .data?.breakfastTimeSlots ??
                            [],
                        mealTimeDinner:
                        availblTimeMeleTimeResult.data?.dinnerTimeslots ??
                            [],
                        mealTimeLunch:
                        availblTimeMeleTimeResult.data?.lunchTimeslots ??
                            [],
                        dataState: availblTimeMeleTimeResult),
                  ],
                ),
              ),
            ),

            /// Buttons
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              color: AppTheme.mainAppBackgroundColor,
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                        outlined: true,
                        backColor: AppTheme.codeColor737373,
                        height: defaultButtonHeight,
                        text: "cancel",
                        strokeWidth: 1.w,
                        onPress: () {}),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppButton(
                        backColor: AppTheme.codeColorB08A4E,
                        enabled: true,
                        height: defaultButtonHeight,
                        text: "Book a Table",
                        onPress: () {
                          if (selectedTime == null) {
                            showValidationToast("Please select a time");
                          } else if (numberOfGuest == 0) {
                            showValidationToast(
                                "Please select the number of guests");
                          } else {
                            context.push(yourInformationDetailsRoute, extra: {
                              GUESTCOUNT: numberOfGuest,
                              DATAVALUE: convertDateAndTime(
                                  _selectedDay ?? DateTime.now(),
                                  selectedTime ?? ""),
                              RESTID: widget.resID,
                            });
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showValidationToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget _buildTimeSection({required List<MealTimeSlots> mealTimeBreakFast,
    required List<MealTimeSlots> mealTimeLunch,
    required List<MealTimeSlots> mealTimeDinner,
    required dynamic dataState}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Title
          Text(
            'Time',
            style: AppTheme.style20BlackBold,
          ),
          SizedBox(height: 16.h),

          /// Breakfast Section
          _buildTimeSection1('Breakfast',
              mealTime: mealTimeBreakFast,
              dataState: dataState, onTimeSelected: (time, index) {
                setState(() {
                  selectedTime = time;
                  selectedIndex = index;
                  print("BreakFast Time $selectedTime");
                });
              }),

          SizedBox(height: 24.h),

          /// Lunch Section
          _buildTimeSection1('Lunch',
              mealTime: mealTimeLunch,
              dataState: dataState, onTimeSelected: (time, index) {
                setState(() {
                  selectedTime = time;
                  selectedIndex = index;
                  print("Lunch Time $selectedTime");
                });
              }),
          SizedBox(height: 24.h),

          /// Lunch Section
        ],
      ),
    );
  }

  Widget _buildTimeSection1(String label,
      {required List<MealTimeSlots> mealTime,
        required dynamic dataState,
        required Function(String?, int?) onTimeSelected}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 44.w,
            runSpacing: 12.h,
            children: List.generate(mealTime.length, (index) {
              final isDisabled = mealTime[index].availability == false;

              return dataState.state == DataState.LOADING
                  ? Text("Loading.......")
                  : InkWell(
                onTap: !isDisabled
                    ? () {
                  onTimeSelected(
                      getTime(
                        mealTime[index].reservationTime ?? "",
                      ),
                      index);
                  selectedIndex = index;
                  setState(
                          () {}); // Call the callback with selected time
                }
                    : null,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 9.h,
                    horizontal: 15.w,
                  ),
                  decoration: BoxDecoration(
                    color: !isDisabled
                        ? selectedIndex == index
                        ? AppTheme.codeColorB08A4E
                        : Colors.transparent
                        : AppTheme.colorCodeF5F5F5,
                    borderRadius: BorderRadius.circular(8.r),
                    border: !isDisabled
                        ? Border.all(
                      color: selectedIndex == index
                          ? AppTheme.whiteColor
                          : AppTheme.colorCodeEAEAEA,
                      width: 1.w,
                    )
                        : null,
                  ),
                  child: Text(
                    getTime(mealTime[index].reservationTime ?? ""),
                    style:
                    AppTheme.styleSize16Weidth700color525252.copyWith(
                      fontSize: 16.sp,
                      color: !isDisabled
                          ? selectedIndex == index
                          ? AppTheme.whiteColor
                          : AppTheme.appBlackColor2
                          : null,
                      decoration: !isDisabled
                          ? TextDecoration.none
                          : TextDecoration.lineThrough,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
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
      final timePart = date.split('.')[0]; // "19:22:09"
      final dateTime = DateFormat.Hms().parse(timePart);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return "Invalid Time";
    }
  }

  String convertDateAndTime(DateTime date, String time) {
    String alltime = "${DateFormat('yyyy-MM-dd').format(date)} $selectedTime";
    DateTime parsedDateTime = DateFormat("yyyy-MM-dd H:mm").parse(alltime);

    // Step 2: Convert to UTC (Zulu time)
    DateTime utcDateTime = parsedDateTime.toUtc();
    print("this Converted Date ${DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(parsedDateTime)}");

    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(parsedDateTime);
  }
}
