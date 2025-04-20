import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/circle_image.dart';

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
          Container(
            width: 50,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: isSelected ? AppTheme.mainAppColor : AppTheme.appGrey19,
            ),
            child: Center(
              child: ImageView(
                initialImg: icon,
                width: 35,
                height: 35,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 11),
            child: Text(
              categoryName,
              style: isSelected
                  ? AppTheme.styleWithTextAppBlackColor3CeraProFonts12w400
                  : AppTheme.styleWithTextAppAppGrey16CeraProFonts12w400,
            ),
          )
        ],
      ),
    );
  }
}
