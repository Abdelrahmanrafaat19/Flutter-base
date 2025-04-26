import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/circle_image.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryTabItem extends StatelessWidget {
  final bool isSelected;
  final String icon;
  final String categoryName;
  const CategoryTabItem(
      {super.key,
      required this.isSelected,
      required this.icon,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Skeleton.replace(
            replacement: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                width: 70,
                height: 72,
                color: Colors.white,
              ),
            ),
            child: Container(
              width: 70,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: isSelected ? AppTheme.mainAppColor : AppTheme.appGrey19,
              ),
              child: Center(
                child: SVGIcons.localSVG(icon,
                    width: 35,
                    height: 35,
                    color: isSelected ? Colors.white : null),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 11),
            child: Text(
              categoryName,
              style: isSelected
                  ? AppTheme.styleWithTextAppBlackColor3CeraProFonts12w500
                  : AppTheme.styleWithTextAppAppGrey16CeraProFonts12w500,
            ),
          )
        ],
      ),
    );
  }
}
