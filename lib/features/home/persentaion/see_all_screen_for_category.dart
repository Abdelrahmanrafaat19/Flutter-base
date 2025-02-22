import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';

import 'widget/search_with_filter.dart';

class SeeAllScreenForCategory extends StatefulWidget {
  const SeeAllScreenForCategory({super.key});

  @override
  State<SeeAllScreenForCategory> createState() =>
      _SeeAllScreenForCategoryState();
}

class _SeeAllScreenForCategoryState extends State<SeeAllScreenForCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        appBar: CustomAppBar(
          navigated: true,
          appContext: context,
          title: "Trending Now",
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(
                    0), // Height of the search bar container
                child: Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: AppSearchBarWithFilter(
                          hasFilter: false,
                          enableSearch: false,
                          onFilterClick: () {},
                          hintTxt: "Type of food, restaurant name",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppTheme.appGrey8, width: 1),
                        ),
                        child: SVGIcons.localSVG(
                            "assets/images/filter_icon.svg",
                            width: 24,
                            height: 24),
                      ), // Avoid keyboard overlap
                    ],
                  ),
                ),
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 85,
                        height: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ0EqHI6h5QgFTXGG_1i2FADG1xulRbVtecA&s",
                            ),
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Container(
                            width: 65,
                            height: 22,
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 5, vertical: 6),
                            decoration: const BoxDecoration(
                                color: AppTheme.lightGreen,
                                borderRadius: BorderRadiusDirectional.only(
                                    topEnd:
                                        Radius.circular(defaultButtonRadius))),
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
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Tako",
                                    style: AppTheme
                                        .styleWithTextBlackAdelleSansExtendedFonts18w500,
                                  ),
                                  Row(
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
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  SVGIcons.localSVG(clockIconPath,
                                      width: 16, height: 16),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.symmetric(
                                        horizontal: 6.0),
                                    child: Text(
                                      "20 Mins",
                                      style:
                                          AppTheme.styleWithAppGrey7Fonts14w400,
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
                                      style:
                                          AppTheme.styleWithAppGrey7Fonts14w400,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SVGIcons.localSVG(gpsIconPath,
                                      width: 16, height: 16),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.symmetric(
                                        horizontal: 6.0),
                                    child: Text(
                                      "Madinty, South Park, B208",
                                      style:
                                          AppTheme.styleWithAppGrey7Fonts14w400,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SVGIcons.localSVG(favoriteIconPath,
                                      width: 24, height: 24),
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
                );
              },
            )
          ],
        ));
  }
}
