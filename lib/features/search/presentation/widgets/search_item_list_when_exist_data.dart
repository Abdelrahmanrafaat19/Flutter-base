// features/search/presentation/widgets/search_item_list_when_exist_data.dart
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';

class SearchItemListWhenExistData extends StatelessWidget {
  final String title;
  final String address;
  final String iconPath;
  final int listLength, index;
  final void Function()? onTap;

  const SearchItemListWhenExistData(
      {super.key,
      required this.title,
      required this.address,
      required this.iconPath,
      required this.listLength,
      required this.index,
      this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: SVGIcons.localSVG(
                              iconPath,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              title,
                              style: AppTheme.style15SemiBoldBlack,
                            ),
                          )
                        ],
                      ),
                      Text(
                        address,
                        style: AppTheme.style14W400code8088A4,
                      ),
                    ],
                  ),
                  Spacer(),
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
      ),
    );
  }
}
