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
            "https://s3-alpha-sig.figma.com/img/952a/0bb4/9ae8b4e2b41dce4f68e8ec0d19430726?Expires=1742774400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=oDhIFQ1GjQEhmq89TuYlRmo0SG7bSBb8P0zpvA6KpgjWhTS3W2h95JhPPsdhMPgn8ZtEStgEvbMicbOYlWOzCKKF~sYB07jbEuSgzkZRBXANZHTp571AQOJFMD0aGOlbbZTKoWKPoUXy2Lo9ZXE7h1lufVKW5J4zCICfiPOXZ6PWq06Qvxq1oS1fg8uAXpORk9T07VG0GygAKXuO49Erv89yBUr9zIKl-9V0LLJbaudWNa97RqDjjSU6VGBU6y3VON44O6omx7tKF3zsKcNtedx~z-OxFW9P8euqlSrjGP4A9xGr6gXY3WK97RQJx63gPmWyBT53Y6Skpifhm15WNg__",
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
