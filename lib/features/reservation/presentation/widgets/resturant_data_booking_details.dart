import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/Assets.dart';
import '../../../../core/widgets/svg_icons.dart';
import '../../data/models/rs_restaurant.dart';

class ResturantDataBookingDetails extends StatelessWidget {
  final RsRestaurant restaurant;
  final String status;

  const ResturantDataBookingDetails(
      {super.key, required this.restaurant, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 85.w,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8.r),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ0EqHI6h5QgFTXGG_1i2FADG1xulRbVtecA&s",
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsetsDirectional.only(start: 16),
              decoration: BoxDecoration(
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
                          restaurant.name ?? "",
                          style: AppTheme
                              .styleWithTextBlackAdelleSansExtendedFonts16w500,
                        ),
                      ),
                      Skeleton.ignore(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Container(
                            height: 32.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:status == "ACTIVITE"
                                  ? AppTheme.lightGreen2
                                  : status == "CONFIRMED"
                                  ? const  Color(0xffF5F5F5)
                                  : AppTheme.lightRed,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              status.toString(),
                              style: TextStyle(
                                color: status == "ACTIVITE"
                                    ? AppTheme.greenColor
                                    : status == "CONFIRMED"
                                        ? AppTheme.codeColor525252
                                        : AppTheme.redColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "cairepro",
                              ),
                            ),
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
                        SVGIcons.localSVG(clockIconPath, width: 16, height: 16),
                        const Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 6.0),
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
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 6.0),
                          child: Text(
                            restaurant.cuisineName ?? "",
                            style: AppTheme.styleWithAppGrey7Fonts14w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Skeleton.replace(
                    replacement: Container(
                      width: 70,
                      height: 20,
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Skeleton.ignore(
                            child: SVGIcons.localSVG(gpsIconPath,
                                width: 16.w, height: 16.h)),
                        Skeleton.ignore(
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 6.w),
                            child: Text(
                              restaurant.address ?? "",
                              style: AppTheme.styleWithAppGrey7Fonts14w400,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
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
    );
  }
}
