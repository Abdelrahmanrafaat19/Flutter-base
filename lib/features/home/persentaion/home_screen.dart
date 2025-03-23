import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/auth/domain/providers/user_provider.dart';
import 'package:flutter_base/features/home/domain/entities/category_entity.dart';
import 'package:flutter_base/features/home/domain/entities/cuisine_entity.dart';
import 'package:flutter_base/features/home/persentaion/Providers/usecase_provider.dart';
import 'package:flutter_base/features/home/persentaion/widget/category_widgets/horizontal_category_listview_with_title.dart';
import 'package:flutter_base/features/home/persentaion/bottom_sheets/filter_bottom_sheet.dart';
import 'package:flutter_base/features/home/persentaion/widget/restaurant_widgets/home_restaurant_listview.dart';
import 'package:flutter_base/features/home/persentaion/widget/search_with_filter.dart';
import 'package:flutter_base/features/home/persentaion/widget/service_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/assets.dart';
import '../../../core/utils/Extensions/utils_exts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      ref
          .read(fetchCuisinesStateNotifierProvider.notifier)
          .call(featured: true);
      ref.read(fetchCategoriesStateNotifierProvider.notifier).call();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cuisinesState = ref.watch(fetchCuisinesStateNotifierProvider);
    final categoriesState = ref.watch(fetchCategoriesStateNotifierProvider);
    handleChangeHomeStatueBarColor();
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
                                    child: SVGIcons.localSVG(
                                        notificationIconPath,
                                        width: 24,
                                        height: 24))),
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
                        hasBorder: false,
                        hasFilter: false,
                        enableSearch: false,
                        onSearchClick: () {},
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
                            onClick: () {
                              ref
                                  .read(fetchCategoriesStateNotifierProvider
                                      .notifier)
                                  .call();
                            },
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
                Column(
                  children: [
                    cuisinesState.data?.isNotEmpty == true
                        ? HorizontalCuisinesListWithTitle(
                            list: cuisinesState.data ??
                                [
                                  Cuisine(),
                                  Cuisine(),
                                  Cuisine(),
                                  Cuisine(),
                                  Cuisine(),
                                ],
                            showLoading:
                                cuisinesState.state == DataState.LOADING,
                            itemClick: () {},
                            onSeeAllClickListener: () {
                              navigateToShowAllCategories();
                            })
                        : const SizedBox(),
                    SizedBox(
                      height: 24,
                    ),
                    categoriesState.data?.isNotEmpty == true
                        ? HomeRestaurantListview(
                            restaurants: categoriesState.data ??
                                [
                                  CategoryEntity(),
                                  CategoryEntity(),
                                  CategoryEntity(),
                                ],
                            showLoading:
                                categoriesState.state == DataState.LOADING,
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToShowAllCategories() {
    context.push(cuisinesScreenRoute);
  }

  void handleChangeHomeStatueBarColor() {
    UtilsExts.handleStatusBarColorWithIcon(
        statusBarColor: Color.lerp(
          AppTheme.appHeaderOne,
          AppTheme.appHeaderTwo,
          .4,
        ),
        statusBarIcons: Brightness.light);
  }
}
