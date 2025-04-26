import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/Assets.dart';
import 'package:flutter_base/core/utils/extensions/string_ex.dart';
import 'package:flutter_base/core/widgets/circle_image.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/restaurant_details/domain/entities/ReviewEntity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReviewItem extends StatelessWidget {
  final ReviewEntity? review;
  const ReviewItem({super.key, this.review});

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
              Skeleton.replace(
                replacement: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(defaultButtonRadius))),
                  child: Container(
                    width: 32,
                    height: 32,
                    color: Colors.white,
                  ),
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: AppTheme.appBlackColor3,
                      borderRadius: BorderRadius.circular(defaultButtonRadius)),
                  child: Center(
                      child: Text(
                    review?.userName?.isEmpty != true
                        ? review!.userName![0].toString()
                        : "",
                    style: AppTheme
                        .styleWithTextWhiteAdelleSansExtendedFonts14w500,
                  )),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Skeleton.replace(
                replacement: Container(
                  width: 110,
                  height: 20,
                  color: Colors.white,
                ),
                child: SizedBox(
                    child: Text(
                  (review?.userName ?? "").ellipsize(28),
                  style: AppTheme
                      .styleWithTextAppBlackColor3AdelleSansExtendedFonts16w500,
                )),
              ),
              Spacer(),
              Skeleton.replace(
                replacement: Container(
                  width: 50,
                  height: 20,
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SVGIcons.localSVG(ratingStarIconPath,
                        width: 16, height: 16),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      (review?.rating ?? 0).toString(),
                      style: AppTheme
                          .styleWithTextAppBlueColor3AdelleSansExtendedFonts16w500,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Skeleton.replace(
            replacement: Container(
              width: 150,
              height: 20,
              color: Colors.white,
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 15,
                child: Text(review?.comment ?? "",
                    style: AppTheme
                        .styleWithTextAppGreen20AdelleSansExtendedFonts14w400)),
          )
        ],
      ),
    );
  }
}
