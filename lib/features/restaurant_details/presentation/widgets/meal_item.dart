import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/circle_image.dart';
import 'package:flutter_base/features/restaurant_details/domain/entities/menu_item_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MealItem extends StatelessWidget {
  final MenuItemEntity? meal;
  const MealItem({super.key, this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.all(
                 defaultPaddingHorizontal),
            child: Row(
              children: [
                Skeleton.replace(
                  replacement: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(defaultButtonRadius))),
                    child: Container(
                      width: 68,
                      height: 68,
                      color: Colors.white,
                    ),
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(defaultButtonRadius))),
                    width: 68,
                    height: 68,
                    child: ImageView(
                      width: 68,
                      height: 68,
                      initialImg: /*meal?.image ??*/ "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZDW-eUQzyd6cb21IAWwZUsmV0XK3BALY13Q&s",
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 110,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Skeleton.replace(
                            replacement: Container(
                              width: 120,
                              height: 20,
                              color: Colors.white,
                            ),
                            child: Text(meal?.name ?? "",
                                style: AppTheme
                                    .styleWithTextAppBlackColor3AdelleSansExtendedFonts14w700),
                          ),

                          Skeleton.replace(
                            replacement: Container(
                              width: 30,
                              height: 20,
                              color: Colors.white,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  meal?.price.toString() ?? "",
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
                          )

                        ],
                      ),
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
                          width: MediaQuery.of(context).size.width - 110,
                          height: 46,
                          child: Text(/*meal?.description??*/"A premium burger made with 100% smashed beef, toopped with fresh sliced mushroom and a savory sauce.",
                            style: AppTheme.styleWithTextAppAppGrey20CeraProFonts12w400
                                .copyWith(overflow: TextOverflow.ellipsis,height: 1.3),
                            maxLines: 3,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
