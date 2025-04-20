import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/data/models/category_model.dart';
import 'package:flutter_base/features/restaurant_details/data/models/restaurant_info_model.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/category_tab_content.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/category_tab_item.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/tag_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/banner_card_items.dart';

class RestaurantDetailsScreen extends ConsumerStatefulWidget {
  const RestaurantDetailsScreen({super.key});

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
  int activeCategoryPageIndex = 0;

  final tags = [
    "🍽️ Dine-in Available",
    "🚀 Fast Service",
    "💳 Online Payment",
    "🎵 Live Music Nights"
  ];

  final times = [
    "03 : 04 pm",
    "03 : 04 pm",
    "03 : 04 pm",
    "03 : 04 pm",
    "03 : 04 pm",
    "03 : 04 pm",
    "03 : 04 pm",
    "03 : 04 pm",
    "03 : 04 pm",
  ];
  final restaurantInfo = [
    RestaurantInfoModel(
      icon: gpsIconPath,
      description: "Madinty, South Park",
    ),
    RestaurantInfoModel(
      icon: grayCalendarIcon,
      description: "Open Now, Closed at 2am",
    )
  ];

  final categorise = [
    CategoryModel(description: "Burger", id: 0),
    CategoryModel(description: "Pizza", id: 1),
    CategoryModel(description: "Pasta", id: 2),
    CategoryModel(description: "Pies", id: 3),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    categoryTabController =
        TabController(length: categorise.length, vsync: this);
    tabController.addListener(() {
      setState(() {
        activePageIndex = tabController.index;
      });
    });
    categoryTabController.addListener(() {
      setState(() {
        activeCategoryPageIndex = categoryTabController.index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          list: ["", "", "", "", ""],
                          height: MediaQuery.of(context).size.height * 0.5,
                          radius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(defaultButtonRadius),
                            bottomStart: Radius.circular(defaultButtonRadius),
                          ),
                          width: MediaQuery.of(context).size.width,
                          showLoading: false,
                          showIndicator: true,
                        ),
                        Positioned(
                            bottom: MediaQuery.of(context).size.height * .17,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              child: Center(
                                child: Wrap(
                                  spacing: 100,
                                  runSpacing: 15,
                                  children: tags.map((tag) {
                                    return TagItem(
                                      tagName: tag,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ))
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
                            "4.5",
                            style: AppTheme
                                .styleWithTextBlackAdelleSansExtendedFonts16w500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(1097 Reviews)",
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
                          Text("Tako Mexico",
                              style: AppTheme
                                  .styleWithTextBlackCeraProFonts22w700),
                          Spacer(),
                          SVGIcons.localSVG(categoryIconPath,
                              width: 16, height: 16),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Mexican",
                            style: AppTheme.styleWithAppGrey7Fonts14w400,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ...restaurantInfo.map((infoItem) => SizedBox(
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
                              "The cost for a table reservation is 500.",
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
                          int crossAxisCount = 3;
                          double crossAxisSpacing = 12;
                          double mainAxisSpacing = 12;
                          double aspectRatio = 2.5;

                          // حساب العرض المتاح للكاردز
                          double totalWidth = constraints.maxWidth;
                          double totalSpacing =
                              (crossAxisCount - 1) * crossAxisSpacing;
                          double itemWidth =
                              (totalWidth - totalSpacing) / crossAxisCount;

                          // نحسب الطول من الـ aspect ratio
                          double itemHeight = itemWidth / aspectRatio;

                          // عدد الصفوف
                          int rowCount = (times.length / crossAxisCount).ceil();

                          // الطول الكلي
                          double totalHeight = (rowCount * itemHeight) +
                              ((rowCount - 1) * mainAxisSpacing);

                          return SizedBox(
                            height: totalHeight,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: crossAxisSpacing,
                                mainAxisSpacing: mainAxisSpacing,
                                childAspectRatio: aspectRatio,
                              ),
                              itemCount: times.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        defaultButtonRadius),
                                    border: Border.all(
                                        width: 1, color: AppTheme.appGrey18),
                                  ),
                                  child: Center(
                                    child: Text(
                                      times[index],
                                      style: AppTheme
                                          .styleWithTextAppGrey16AdelleSansExtendedFonts16w500,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
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
                      TabBar(
                        isScrollable: true,
                        labelPadding: EdgeInsets.zero,
                        indicatorColor: Colors.transparent,
                          controller: categoryTabController,
                          tabs:
                        categorise
                            .map((item) => CategoryTabItem(
                                isSelected:
                                    categorise[activeCategoryPageIndex].id ==
                                        item.id,
                                icon:
                                    "https://s7d1.scene7.com/is/image/mcdonalds/mcdonalds-cheeseburger-april-promo:nutrition-calculator-tile?wid=822&hei=822&dpr=off",
                                categoryName: item.description ?? ""))
                            .toList()
                      ),

                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CategoryTabContent(index:categoryTabController.index),
              ),
              SliverToBoxAdapter(
                child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: Text("Show all Menu",style: AppTheme.styleWithTextMainAppColorCeraProFonts14w500.copyWith(decoration: TextDecoration.underline),)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Divider(
                        thickness: 1,
                        color: AppTheme.appGrey2,
                      ),
                    )
                  ],
                ) ,
              ),
              SliverToBoxAdapter(
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Details",style: AppTheme.styleWithTextAppBlueColor3SansExtendedFonts16w700,),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SVGIcons.localSVG(markerWithMapIcon,width: 24,height: 24),
                          SizedBox(
                            width: 12,
                          ),
                          Text("Madinty, South Park B28",style: AppTheme.styleWithTextAppGrey16CeraProFonts14w500,)
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Image.asset(mapImage,width: double.infinity,),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SVGIcons.localSVG(linkIcon,width: 24,height: 24),
                          SizedBox(width: 12,),
                          Text("Tako Mexico.com",style: AppTheme.styleWithTextAppBlueColor4SmRegularFonts14w500.copyWith(decoration: TextDecoration.underline),)
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SVGIcons.localSVG(markerWithMapIcon,width: 24,height: 24),
                          SizedBox(
                            width: 12,
                          ),
                          Text("Madinty, South Park B28",style: AppTheme.styleWithTextAppGrey16CeraProFonts14w500,)
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SVGIcons.localSVG(callIcon,width: 24,height: 24),
                          SizedBox(
                            width: 12,
                          ),
                          Text("+201090880259",style: AppTheme.styleWithTextAppGrey16CeraProFonts14w500,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:  SizedBox(
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
                          width: 24, height: 24,color: Colors.white),
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
}
