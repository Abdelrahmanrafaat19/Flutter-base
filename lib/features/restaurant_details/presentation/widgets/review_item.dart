import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/Assets.dart';
import 'package:flutter_base/core/utils/extensions/string_ex.dart';
import 'package:flutter_base/core/widgets/circle_image.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultButtonRadius)),
                child: ImageView(width: 32, height: 32, initialImg: ""),
              ),
              SizedBox(
                width: 12,
              ),
              SizedBox(
                  width: 60,
                  child: Text(
                    "Yassen Mostafa".ellipsize(28),
                    style: AppTheme
                        .styleWithTextAppBlackColor3AdelleSansExtendedFonts16w500,
                  )),
              Spacer(),
              SVGIcons.localSVG(ratingStarIconPath,
                  width: 16, height: 16),
              SizedBox(
                width: 4,
              ),
              Text("4.5",style: AppTheme.styleWithTextAppBlueColor3AdelleSansExtendedFonts16w500,)
            ],
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width -110,
              child: Text(
                  "I had an amazing dining experience! "
                  "I had an amazing dining experience! "
                  "I had an amazing dining experience! "
                  "I had an amazing dining experience! "
                  "I had an amazing dining experience! "
                  "The warm atmosphere and attentive service truly made my visit memorable.",style: AppTheme.styleWithTextAppGreen20AdelleSansExtendedFonts14w400
                  ))

        ],
      ),
    );
  }
}
