import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/Assets.dart';
import '../../../../core/widgets/svg_icons.dart';

class ResturantData extends StatelessWidget {
  const ResturantData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: double.infinity,
              margin:  EdgeInsets.symmetric(
                  horizontal: defaultPaddingHorizontal.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 85.w,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadiusDirectional.all(
                      Radius.circular(8.r)
                      ),
                      image:const  DecorationImage(
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

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Skeleton.replace(
                            replacement: Container(
                              width: 150,
                              height: 20,
                              color: Colors.white,
                            ),
                            child:  Text(
                              "Tako Mexico",
                              style: AppTheme
                                  .styleWithTextBlackAdelleSansExtendedFonts16w500,
                            ),
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
                                        width: 16, height: 16)),
                                Skeleton.ignore(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.symmetric(
                                        horizontal: 6.0),
                                    child: Text(
                                      "Madinty, South Park B28" ,
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
            ),
          )
        ],
      ),
    );
  }
}
