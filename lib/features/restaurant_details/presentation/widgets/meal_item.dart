import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/circle_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      width: double.infinity,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
      ),
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: defaultPaddingHorizontal),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(defaultButtonRadius))
            ),
            width: 68,
            height: 68,
            child: ImageView(
              width: 68,
              height: 68,
              initialImg:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa9Qq1rV_svdydH5u3O8r5ZmT8udMBnSuKeA&s",
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width -110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Original Mushroom Burger",
                        style: AppTheme
                            .styleWithTextAppGreen17AdelleSansExtendedFonts14w400),
                    Spacer(),
                    Text(
                      "45.99",
                      style: AppTheme
                          .styleWithTextMainAppColorAdelleSansExtendedFonts18w700,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "LE",
                      style: AppTheme
                          .styleWithTextMainAppColorAdelleSansExtendedFonts12w500,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width -110,
                  child: Text("A premium burger made with 100% smashed beef, toopped with fresh sliced mushroom and a savory sauce.",style: AppTheme.styleWithTextAppAppGrey20CeraProFonts12w400.copyWith(overflow: TextOverflow.ellipsis),maxLines: 3,))
            ],
          )
     ],
      ),
    );
  }
}
