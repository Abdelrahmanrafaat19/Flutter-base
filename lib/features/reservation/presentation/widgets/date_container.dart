import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/Assets.dart';
import '../../../../core/widgets/svg_icons.dart';
import 'calender_bottom_sheet.dart';

class DateContainer extends StatefulWidget {
  final void Function(DateTime, DateTime)?onDaySelected ;
  final DateTime focusedDay ;
  final DateTime? selectedDay;
  final List<DateTime> days;
  final List<String> dates;
    int isSelected=0;
   DateContainer({super.key,required this.onDaySelected, required this.focusedDay,required this.selectedDay, required this.days, required this.dates, required this.isSelected});

  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.colorCodeEAEAEA, width: 1.w),
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date", style: AppTheme.style20BlackBold),
              InkWell(
                onTap: () {

                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    isScrollControlled: true,
                    builder: (_) =>  CalendarBottomSheet(
                      focusedDay: widget.focusedDay,
                      selectedDay: widget.selectedDay,

                      onDaySelected:widget.onDaySelected,
                    ),
                  );
                },
                child:
                    SVGIcons.localSVG(calenderIcon, width: 24.w, height: 24.h),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            color: AppTheme.colorCodeEAEAEA,
            height: 2.h,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              bool isSelected = widget.isSelected == index;
              bool isClickable = index != 0;

              return InkWell(
                onTap: isClickable
                    ? () {
                  setState(() {
                    widget.isSelected = index;
                  });
                }
                    : null,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: widget.isSelected == index
                        ? AppTheme.lightBrown
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: widget.isSelected == index
                        ? Border.all(
                            color: AppTheme.codeColorB08A4E,
                            width: 1.w,
                          )
                        : null,
                  ),
                  child: Column(
                    children: [
                      Text(DateFormat('E').format(widget.days[index]),
                          style: AppTheme.style20BlackBold.copyWith(
                            fontWeight: FontWeight.w900,
                            color:isClickable?( widget.isSelected == index
                                ? AppTheme.codeColorB08A4E
                                : AppTheme.colorCode171717):AppTheme.colorCodeEAEAEA,
                          )),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        child: Text(
                          widget.days[index].day.toString(),
                          style: AppTheme.style20BlackBold.copyWith(
                            fontWeight: FontWeight.w900,
                            color:isClickable?( widget.isSelected == index
                                ? AppTheme.codeColorB08A4E
                                : AppTheme.colorCode171717):AppTheme.colorCodeEAEAEA,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
