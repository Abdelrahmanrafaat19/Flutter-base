import 'package:flutter/material.dart';

import '../../../../core/Theme/app_theme.dart';

class FoodItemList extends StatelessWidget {
  const FoodItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 150,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.appGrey8,
          ),
          color: AppTheme.whiteColor,
          borderRadius:
          BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Image.network(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuC9a-P4LsUdtmurXIK_ZugkN70_uJbJ7vJw&s",
            width: 56,
            height: 56,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Original Mushroom Burger",
            textAlign: TextAlign.center,
            style: AppTheme
                .fonStyle13W50022252BColor,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Text(
                "45.99 ",
                style: AppTheme
                    .fontStyleW70018code008080Color,
              ),
              Text(
                "LE",
                style: AppTheme
                    .fontStyleW70018code008080Color
                    .copyWith(
                  fontSize: 12,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
