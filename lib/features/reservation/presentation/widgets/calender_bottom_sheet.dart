import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/Theme/app_theme.dart';

class CalendarBottomSheet extends StatelessWidget {
  final DateTime focusedDay;

  final DateTime? selectedDay;
  final void Function(DateTime, DateTime)? onDaySelected;

  const CalendarBottomSheet({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          color: AppTheme.whiteColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Date',
              style: AppTheme.style20BlackBold,
            ),
            SizedBox(height: 16.h),
            TableCalendar(
              firstDay: DateTime(2025),
              lastDay: DateTime(2030),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: onDaySelected,
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: Colors.black),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontWeight: FontWeight.w600),
                weekendStyle: TextStyle(fontWeight: FontWeight.w600),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Color(0xFFD2A76F),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: AppTheme.whiteColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // You can use _selectedDay here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD2A76F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text(
                "Show Results",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
