import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/persentaion/widget/category_widgets/horizontal_category_listview_with_title.dart';
import 'package:flutter_base/features/home/persentaion/bottom_sheets/filter_bottom_sheet.dart';
import 'package:flutter_base/features/home/persentaion/widget/restaurant_widgets/home_restaurant_listview.dart';
import 'package:flutter_base/features/home/persentaion/widget/search_with_filter.dart';
import 'package:flutter_base/features/home/persentaion/widget/service_options.dart';

import '../../../core/constants/assets.dart';
import '../../../core/utils/Extensions/utils_exts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    UtilsExts.handleStatusBarColorWithIcon(
        statusBarColor:
        Color.lerp(AppTheme.appHeaderOne, AppTheme.appHeaderTwo, .4),statusBarIcons: Brightness.light);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: defaultPaddingHorizontal, vertical: 24),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.appHeaderOne, AppTheme.appHeaderTwo],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SVGIcons.localSVG(homeGpsIconPath,
                              width: 24, height: 24),
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: defaultButtonRadius),
                            child: Text(
                              "Madinty,Bulding 64",
                              style: AppTheme
                                  .styleWithTextWhiteAdelleSansExtendedFonts16w500,
                            ),
                          ),
                          Spacer(),
                          Stack(children: [
                            Align(
                                alignment: AlignmentDirectional.center,
                                child: InkWell(
                                    onTap: () {},
                                    child: SVGIcons.localSVG(notificationIconPath,
                                        width: 24, height: 24))),
                            Positioned(
                              right: 4,
                              top: 1,
                              child: Container(
                                height: 6,
                                width: 6,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.appRed),
                              ),
                            )
                          ])
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      AppSearchBarWithFilter(
                        hasFilter: false,
                        enableSearch: false,
                        onSearchClick: () {
                          print("asdfkl");
                          showFilterBottomSheet();
                        },
                        hintTxt: "Type of food, restaurants name",
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          ServiceOptions(
                            icon: SVGIcons.localSVG(calendarIconPath,
                                width: 24, height: 24),
                            title: "Reserve a table",
                            onClick: () {},
                          ),
                          const Spacer(),
                          ServiceOptions(
                            icon: SVGIcons.localSVG(shopIconPath,
                                width: 24, height: 24),
                            title: "Pick-Up",
                            onClick: () {},
                          ),
                          const Spacer(),
                          ServiceOptions(
                            icon: SVGIcons.localSVG(starIconPath,
                                width: 24, height: 24),
                            title: "In Restaurant?",
                            onClick: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: defaultPaddingHorizontal),
                  child: Column(
                    children: [
                      HorizontalCategoryListWithTitle(
                          list: ["", "", "", "", "", "", ""],
                          showLoading: false,
                          itemClick: () {},
                          onSeeAllClickListener: () {}
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      HomeRestaurantListview(restaurants: ["","",""], showLoading: false)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    UtilsExts.handleStatusBarColorWithIcon(
        statusBarColor: Colors.white);
  }

  void showFilterBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        context: context,
        builder: (BuildContext context) => FilterBottomSheet());
  }
}
