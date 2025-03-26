// features/search/presentation/widgets/search_item_list_initil_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/assets.dart';

import '../../../../core/widgets/svg_icons.dart';

class SearchItemListInitilBody extends StatelessWidget {
  final String title;
  final String subTitle;
  final String iconPath;
  final bool hasSubTitle;
  final int listLength, index;
  const SearchItemListInitilBody(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.iconPath,
      required this.hasSubTitle,
      required this.listLength,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
           
            horizontal: 16,
          ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.appGrey8,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SVGIcons.localSVG(
                    iconPath,
                    width: 24,
                    height: 24,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: hasSubTitle == false
                      ? Text(
                          title,
                          style: AppTheme.style15SemiBoldBlack,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subTitle,
                              style: AppTheme.style14W400code8088A4,
                            ),
                            Text(
                              title,
                              style: AppTheme.style15SemiBoldBlack,
                            )
                          ],
                        ),
                ),
                SVGIcons.localSVG(arrowRightIcons,
                    color: AppTheme.appGrey7, width: 24, height: 24)
              ],
            ),
          ),
          index != listLength - 1
              ? Divider(
                  height: 2,
                  color: AppTheme.appGrey8,
                )
              : SizedBox()
        ],
      ),
    );
  }
}
