import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Theme/app_theme.dart';

class GuestContainer extends StatefulWidget {
  final int guestCounter;
  final void Function() increment,decrement;

  const GuestContainer({super.key, required this.guestCounter, required this.increment, required this.decrement,});

  @override
  State<GuestContainer> createState() => _GuestContainerState();
}

class _GuestContainerState extends State<GuestContainer> {
  int numberOfGuests=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.colorCodeEAEAEA, width: 1.w),
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Guests', style: AppTheme.style20BlackBold),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.colorCodeEAEAEA,width: 1.w,),
                borderRadius: BorderRadius.circular(8.r)
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: widget.decrement,
                    icon: Icon(
                      Icons.remove,
                      color: AppTheme.colorCode171717,
                      size: 24.sp,
                    )),
                SizedBox(
                  width: 10.w,
                ),
                Text(widget.guestCounter.toString(),
                    style: AppTheme.style20BlackBold
                        .copyWith(fontWeight: FontWeight.w500)),

                SizedBox(
                  width: 10.w,
                ),
                IconButton(
                    onPressed:widget.increment,
                    icon: Icon(
                      Icons.add,
                      color: AppTheme.colorCode171717,
                      size: 24.sp,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
