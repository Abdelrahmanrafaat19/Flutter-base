import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/circle_image.dart';

class RestaurantCategory extends StatelessWidget {
  final String? categoryImg;
  final String? categoryName;
  final double width;
  final double height;
  const RestaurantCategory({super.key, this.categoryImg, this.categoryName, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultButtonRadius)
      ),
      child: Stack(
        children: [

          ImageView(
            width: width,
            height: height,
            initialImg: categoryImg
          ),

          Container(
            width: width,
            height: height,
            color: CupertinoColors.black.withOpacity(.3),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(categoryName??"",style: AppTheme.styleWithTextWhiteAdelleSansExtendedFonts16w500,),
          ),
        ],
      ),
    );
  }
}
