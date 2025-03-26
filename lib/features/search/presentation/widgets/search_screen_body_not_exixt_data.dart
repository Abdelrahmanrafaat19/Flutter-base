// features/search/presentation/widgets/search_screen_body_not_exixt_data.dart
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/app_button.dart';

import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/svg_icons.dart';

class SearchScreenBodyNotExixtData extends StatelessWidget {
  const SearchScreenBodyNotExixtData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 70),
      decoration:const  BoxDecoration(
        color: AppTheme.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.code22252BColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 60,
              height: 60,
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppTheme.code22252BColor.withOpacity(0.21),
                shape: BoxShape.circle,
              ),
              child: SVGIcons.localSVG(gpsIcon,
                  color: AppTheme.appGrey7, width: 24, height: 24),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "No Results Found!",
            style: AppTheme.style20SemiBoldcode333740,
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Try searching for something else or \n in a different area.",
            textAlign: TextAlign.center,
            style: AppTheme.style15W400appGrey7Color,
          ),
          const SizedBox(
            height: 35,
          ),
          AppButton(
            width: double.infinity,
            height: defaultButtonHeight,
            text: "Start a New Search",
            backColor: AppTheme.code008080Color,
            onPress: () async {},
          ),
        ],
      ),
    );
  }
}
