import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/core/utils/extensions/request_handle_extension.dart';
import 'package:flutter_base/core/utils/map_utils.dart';
import 'package:flutter_base/core/utils/time_utils.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/data/models/category_model.dart';
import 'package:flutter_base/features/restaurant_details/data/models/restaurant_info_model.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/category_tab_content.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/category_tab_item.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/reviews_content.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/tag_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/localization/LanguageProvider.dart';
import '../../../../core/widgets/app_button.dart';
import '../providers/use_case_provider.dart';
import '../widgets/banner_card_items.dart';

class RestaurantDetailsScreen extends ConsumerStatefulWidget {
  final String restaurantId;
  const RestaurantDetailsScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  ConsumerState<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState
    extends ConsumerState<RestaurantDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TabController categoryTabController;
  int activePageIndex = 0;
  ValueNotifier<int> activeCategoryPageIndex = ValueNotifier(0);

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      setState(() {
        activePageIndex = tabController.index;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(langProvider.notifier).fetchLocale("en");
      fetchRestaurantMenus(widget.restaurantId);
      fetchRestaurantDetails(widget.restaurantId);
      fetchRestaurantReviews(widget.restaurantId);
    });
    super.initState();
  }

  final List<String> imageUrls = [
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    'https://www.wondergifts.ae/cdn/shop/files/3_-_Copy_135c0b16-27fa-47cd-87fa-7f52d16586dc_980x640.jpg?v=1730360580',
    // زوّد الصور حسب الحاجة
  ];

  @override
  Widget build(BuildContext context) {
    final restaurantState = ref.watch(fetchRestaurantDetailsStateProvider);

    handleState(fetchRestaurantDetailsStateProvider, showLoading: true);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                  automaticallyImplyLeading: false, // Add this line
                  expandedHeight: MediaQuery.of(context).size.height * .45,
                  titleSpacing: 0,
                  pinned: true,
                  elevation: 0,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPaddingHorizontal),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: SVGIcons.localSVG(backWithGrayBackgroundIcon,
                                width: 32, height: 32)),
                        Spacer(),
                        SVGIcons.localSVG(shareWithGrayBackgroundIcon,
                            width: 32, height: 32),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                            onTap: () {},
                            child: SVGIcons.localSVG(
                                false
                                    ? favoriteIconWithBackgroundPath
                                    : unFavoriteWithGrayBackgroundIcon,
                                width: 32,
                                height: 32)),
                      ],
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        BannerCardItems(
                          list: imageUrls ?? [],
                          mainImage: restaurantState.data?.mainImage,
                          height: MediaQuery.of(context).size.height * 0.5,
                          radius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(defaultButtonRadius),
                            bottomStart: Radius.circular(defaultButtonRadius),
                          ),
                          width: MediaQuery.of(context).size.width,
                          showLoading: false,
                          showIndicator:  true,
                        ),
                        Positioned(
                            bottom: imageUrls.isNotEmpty == true ? MediaQuery.of(context).size.height * .12 : MediaQuery.of(context).size.height * .03,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              child: Center(
                                child: Wrap(
                                  spacing: 100,
                                  runSpacing: 15,
                                  children: (restaurantState.data?.tags ?? [])
                                      .map((tag) {
                                    return TagItem(
                                      tagName: tag.text ?? "",
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),
                        // Container(
                        //   height: MediaQuery.of(context).size.height * 0.5,
                        //   color: Colors.black.withOpacity(.5),
                        // ),
                      ],
                    ),
                  )),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(defaultPaddingHorizontal),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: defaultButtonRadius, vertical: 6),
                            decoration: BoxDecoration(
                                color: AppTheme.lightGreen,
                                borderRadius: BorderRadiusDirectional.circular(
                                    defaultButtonRadius)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SVGIcons.localSVG(discountIconPath,
                                    width: 16, height: 16),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "15% OFF",
                                  style: AppTheme
                                      .styleWithTextGreenAdelleSansExtendedFonts12w400,
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          SVGIcons.localSVG(ratingStarIconPath,
                              width: 16, height: 16),
                          const SizedBox(width: 4),
                          Text(
                            restaurantState.data?.rating.toString() ?? "0",
                            style: AppTheme
                                .styleWithTextBlackAdelleSansExtendedFonts16w500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(${restaurantState.data?.reviewsCount ?? 0} Reviews)",
                            style: AppTheme
                                .styleWithTextAppGrey7AdelleSansExtendedFonts14w400
                                .copyWith(decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text("${restaurantState.data?.name ?? ""}",
                              style: AppTheme
                                  .styleWithTextBlackCeraProFonts22w700),
                          Spacer(),
                          SVGIcons.localSVG(categoryIconPath,
                              width: 16, height: 16),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${restaurantState.data?.cuisineName ?? ""}",
                            style: AppTheme.styleWithAppGrey7Fonts14w400,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ...[
                        RestaurantInfoModel(
                            icon: gpsIconPath,
                            description: restaurantState.data?.address),
                        RestaurantInfoModel(
                            icon: grayCalendarIcon,
                            description: getOpenStatus(
                                restaurantState.data?.openTime ?? "",
                                restaurantState.data?.closeTime ?? ""))
                      ].map((infoItem) => SizedBox(
                            height: 32,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SVGIcons.localSVG(infoItem.icon ?? "",
                                    width: 16, height: 16),
                                SizedBox(width: 4),
                                Text(
                                  infoItem.description ?? "",
                                  style: AppTheme
                                      .styleWithTextAppGrey16CeraProFonts14w500,
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 32,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SVGIcons.localSVG(cashIcon, width: 20, height: 24),
                            SizedBox(width: 4),
                            Text(
                              "The cost for a table reservation is \$${restaurantState.data?.singleReservationCost}.",
                              style: AppTheme
                                  .styleWithTextAppGrey16CeraProFonts14w500,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TabBar(
                        controller: tabController,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        labelPadding: EdgeInsets.all(0),
                        tabs: [
                          Tab(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              margin: EdgeInsetsDirectional.only(end: 8),
                              child: Center(
                                child: Text(
                                  "Reservation",
                                  style: activePageIndex == 0
                                      ? AppTheme
                                          .styleWithTextWhiteAdelleSansExtendedFonts16w500
                                      : AppTheme
                                          .styleWithTextAppBlackColor3AdelleSansExtendedFonts16w500,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppTheme.appBlackColor2,
                                      width: activePageIndex == 0 ? 0 : 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(defaultButtonRadius)),
                                  color: activePageIndex == 0
                                      ? AppTheme.appBlackColor2
                                      : Colors.white),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              margin: EdgeInsetsDirectional.only(start: 8),
                              child: Center(
                                child: Text(
                                  "Pick-Up",
                                  style: activePageIndex == 1
                                      ? AppTheme
                                          .styleWithTextWhiteAdelleSansExtendedFonts16w500
                                      : AppTheme
                                          .styleWithTextAppBlackColor3AdelleSansExtendedFonts16w500,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppTheme.appBlackColor2,
                                      width: activePageIndex == 1 ? 0 : 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(defaultButtonRadius)),
                                  color: activePageIndex == 1
                                      ? AppTheme.appBlackColor2
                                      : Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPaddingHorizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 28,
                      ),
                      Row(children: [
                        SVGIcons.localSVG(calendarIconPath,
                            width: 20, height: 20),
                        SizedBox(width: 6),
                        Text(
                          "Booked 24 times Today!",
                          style: AppTheme
                              .styleWithTextAppGreen17AdelleSansExtendedFonts113w400,
                        ),
                      ]),
                      SizedBox(
                        height: 16,
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (restaurantState.state == DataState.SUCCESS) {
                            var timeSlots = restaurantState
                                    .data?.quickReservationTimeSlots ??
                                [];
                            int crossAxisCount = 3;
                            double crossAxisSpacing = 12;
                            double mainAxisSpacing = 12;
                            double aspectRatio = 2.5;

                            double totalWidth = constraints.maxWidth;
                            double totalSpacing =
                                (crossAxisCount - 1) * crossAxisSpacing;
                            double itemWidth =
                                (totalWidth - totalSpacing) / crossAxisCount;

                            // نحسب الطول من الـ aspect ratio
                            double itemHeight = itemWidth / aspectRatio;

                            // عدد الصفوف
                            int rowCount =
                                (timeSlots.length / crossAxisCount).ceil();

                            // الطول الكلي
                            double totalHeight = (rowCount * itemHeight) +
                                ((rowCount - 1) * mainAxisSpacing);

                            return Column(
                              children: [
                                SizedBox(
                                  height: totalHeight,
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: crossAxisSpacing,
                                      mainAxisSpacing: mainAxisSpacing,
                                      childAspectRatio: aspectRatio,
                                    ),
                                    itemCount: timeSlots.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              defaultButtonRadius),
                                          border: Border.all(
                                              width: 1,
                                              color: AppTheme.appGrey18),
                                        ),
                                        child: Center(
                                          child: Text(
                                            formatTo12Hour(timeSlots[index]
                                                    .reservationTime ??
                                                ""),
                                            style: AppTheme
                                                .styleWithTextAppGrey16AdelleSansExtendedFonts16w500
                                                .copyWith(
                                                    decoration: timeSlots[index]
                                                                .availability ==
                                                            true
                                                        ? TextDecoration.none
                                                        : TextDecoration
                                                            .lineThrough),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.appGrey2,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Consumer(builder: (context, ref, child) {
                        var restaurantMenu =
                            ref.watch(fetchLimitRestaurantMenuItemsStateProvider);
                        if (restaurantMenu.state == DataState.SUCCESS) {
                          var categories =
                              restaurantMenu.data?.categoryItems ?? [];
                          categoryTabController = TabController(
                              length: categories.length ?? 0, vsync: this);
                          categoryTabController.addListener(() {
                            activeCategoryPageIndex.value =
                                categoryTabController.index;
                          });
                          return ValueListenableBuilder(
                            valueListenable: activeCategoryPageIndex,
                            builder: (context, value, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Menu Highlights",
                                    style: AppTheme
                                        .styleWithTextAppBlueColor3SansExtendedFonts16w700,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  TabBar(
                                      isScrollable: true,
                                      labelPadding: EdgeInsets.zero,
                                      indicatorColor: Colors.transparent,
                                      controller: categoryTabController,
                                      tabs: categories
                                          .map((item) => CategoryTabItem(
                                              isSelected: categories[value]
                                                      .categoryId ==
                                                  item.categoryId,
                                              icon: burgerIcon,
                                              categoryName:
                                                  item.categoryName ?? ""))
                                          .toList()),
                                ],
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      }),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: activeCategoryPageIndex,
                  builder: (context, value, _) {
                    return SliverToBoxAdapter(
                      child: CategoryTabContent(index: value),
                    );
                  }),
              SliverToBoxAdapter(
                child:
                restaurantState.state == DataState.SUCCESS && restaurantState.data?.categoryIds?.isNotEmpty == true ?
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                          child: InkWell(
                        onTap: () {
                          navigateToMenuScreen();
                        },
                        child: Text(
                          "Show all Menu",
                          style: AppTheme
                              .styleWithTextMainAppColorCeraProFonts14w500
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      )),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Divider(
                        thickness: 1,
                        color: AppTheme.appGrey2,
                      ),
                    )
                  ],
                ) : const SizedBox(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPaddingHorizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: AppTheme
                            .styleWithTextAppBlueColor3SansExtendedFonts16w700,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SVGIcons.localSVG(markerWithMapIcon,
                              width: 24, height: 24),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            restaurantState.data?.address ?? "",
                            style: AppTheme
                                .styleWithTextAppGrey16CeraProFonts14w500,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          if (restaurantState.data?.location != null) {
                            var location = restaurantState.data?.location;
                            openMap(location?.lat ?? "", location?.lon ?? "");
                          }
                        },
                        child: Image.asset(
                          mapImage,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          if (restaurantState.data?.location != null) {
                            var location = restaurantState.data?.location;
                            openMap(location?.lat ?? "", location?.lon ?? "");
                          }
                        },
                        child: Row(
                          children: [
                            SVGIcons.localSVG(linkIcon, width: 24, height: 24),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              restaurantState.data?.address ?? "",
                              style: AppTheme
                                  .styleWithTextAppBlueColor4SmRegularFonts14w500
                                  .copyWith(
                                      decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SVGIcons.localSVG(grayCalendarIcon,
                              width: 24, height: 24),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            getOpenStatus(restaurantState.data?.openTime ?? "",
                                restaurantState.data?.closeTime ?? ""),
                            style: AppTheme
                                .styleWithTextAppGrey16CeraProFonts14w500,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SVGIcons.localSVG(callIcon, width: 24, height: 24),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            restaurantState.data?.phone ?? "",
                            style: AppTheme
                                .styleWithTextAppGrey16CeraProFonts14w500,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Consumer(builder: (_, ref, child) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPaddingHorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppTheme.appGrey2,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Reviews",
                          style: AppTheme
                              .styleWithTextAppBlueColor3SansExtendedFonts16w700,
                        ),
                        ReviewsContent(),
                      ],
                    ),
                  ),
                );
              }),
              SliverToBoxAdapter(
                child:
                restaurantState.state == DataState.SUCCESS && restaurantState.data?.reviewsCount != 0 ?
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                          child: InkWell(
                            onTap: () {
                              navigateToReviewsScreen();
                            },
                            child: Text(
                              "Show all Menu",
                              style: AppTheme
                                  .styleWithTextMainAppColorCeraProFonts14w500
                                  .copyWith(decoration: TextDecoration.underline),
                            ),
                          )),
                    ),
                  ],
                ) : const SizedBox(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    offset: Offset(0, -1), // Negative Y for top shadow
                    blurRadius: 6, // How soft the shadow is
                    spreadRadius: 0, // Optional: how much it spreads
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Expanded(
                child: AppButton(
                  onPress: () {},
                  height: 56,
                  backColor: AppTheme.mainAppColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SVGIcons.localSVG(calendarIconPath,
                          width: 24, height: 24, color: Colors.white),
                      SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "Book a Table",
                        style: AppTheme
                            .styleWithTextWhiteAdelleSansExtendedFonts16w500,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void fetchRestaurantMenus(String restaurantId) {
    ref
        .read(fetchLimitRestaurantMenuItemsStateProvider.notifier)
        .call(restaurantId: /*restaurantId*/"136", itemsCountLimit: 5);
  }

  void fetchRestaurantDetails(String restaurantId) {
    ref
        .read(fetchRestaurantDetailsStateProvider.notifier)
        .call(/*restaurantId*/"136", "en");
  }

  void fetchRestaurantReviews(String restaurantId) {
    ref
        .read(fetchRestaurantLimitReviewsUseCaseStateProvider.notifier)
        .call(restaurantId:/*restaurantId*/ "136", localeIsoCode: "en");
  }

  void navigateToMenuScreen() {
    context.push(menuScreenRoute,
        extra: {RESTAURANT_ID_KEY: widget.restaurantId.toString()});
  }

  void navigateToReviewsScreen() {
    context.push(restaurantReviewsRoute,
        extra: {RESTAURANT_ID_KEY: widget.restaurantId.toString()});
  }
}
