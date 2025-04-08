import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/Constants/Constants.dart';
import '../../../../../core/Theme/app_theme.dart';
import '../../../../../core/constants/Assets.dart';
import '../../../../../core/widgets/svg_icons.dart';
import '../../../domain/entities/restaurant_entity.dart';

class VerticalRestaurantCard extends StatefulWidget {
  final Restaurant? restaurant;
  const VerticalRestaurantCard({super.key, this.restaurant});

  @override
  State<VerticalRestaurantCard> createState() => _VerticalRestaurantCardState();
}

class _VerticalRestaurantCardState extends State<VerticalRestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
            horizontal: defaultPaddingHorizontal, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 85,
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(8),
                  bottomStart: Radius.circular(8),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ0EqHI6h5QgFTXGG_1i2FADG1xulRbVtecA&s",
                  ),
                ),
              ),
              child: Skeleton.ignore(
                child: Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Container(
                    width: 65,
                    height: 22,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 3, vertical: 6),
                    decoration: const BoxDecoration(
                        color: AppTheme.lightGreen,
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(defaultButtonRadius))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SVGIcons.localSVG(discountIconPath,
                            width: 14, height: 14),
                        Text(
                          "15% OFF",
                          style: AppTheme
                              .styleWithTextGreenAdelleSansExtendedFonts12w400
                              .copyWith(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsetsDirectional.only(start: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.appGrey8, width: 1),
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(defaultButtonRadius),
                      bottomEnd: Radius.circular(defaultButtonRadius),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Skeleton.replace(
                          replacement: Container(
                            width: 150,
                            height: 20,
                            color: Colors.white,
                          ),
                          child: Text(
                            widget.restaurant?.name ?? "",
                            style: AppTheme
                                .styleWithTextBlackAdelleSansExtendedFonts16w500,
                          ),
                        ),
                        Skeleton.ignore(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              children: [
                                SVGIcons.localSVG(ratingStarIconPath,
                                    width: 16, height: 16),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "4.5",
                                  style: AppTheme
                                      .styleWithTextBlackAdelleSansExtendedFonts14w500,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Skeleton.replace(
                      replacement: Container(
                        width: 100,
                        height: 20,
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SVGIcons.localSVG(clockIconPath,
                              width: 16, height: 16),
                          const Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 6.0),
                            child: Text(
                              "20 Mins",
                              style: AppTheme.styleWithAppGrey7Fonts14w400,
                            ),
                          ),
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.appGrey15),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          SVGIcons.localSVG(categoryIconPath,
                              width: 16, height: 16),
                          const Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 6.0),
                            child: Text(
                              "Mexican",
                              style: AppTheme.styleWithAppGrey7Fonts14w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Skeleton.replace(
                            replacement: Container(
                              width: 70,
                              height: 20,
                              color: Colors.white,
                            ),
                            child: SVGIcons.localSVG(gpsIconPath,
                                width: 16, height: 16)),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 6.0),
                          child: Text(
                            widget.restaurant?.location ?? "",
                            style: AppTheme.styleWithAppGrey7Fonts14w400,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const Spacer(),
                        Skeleton.ignore(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPaddingHorizontal),
                            child: SVGIcons.localSVG(
                                widget.restaurant?.isFavorite == true ?
                                favoriteIconWithBackgroundPath : unFavoriteIconPath,
                                width: 24, height: 24),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
