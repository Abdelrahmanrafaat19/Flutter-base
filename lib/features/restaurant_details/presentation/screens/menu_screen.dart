import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/localization/LanguageProvider.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/features/restaurant_details/presentation/providers/use_case_provider.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/meal_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/assets.dart';
import '../../data/models/menu_model.dart';
import '../widgets/category_tab_item.dart';

class MenuScreen extends ConsumerStatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen>
    with TickerProviderStateMixin {
  late TabController categoryTabController;

  late ScrollController scrollController;
  int selectedCategoryIndex = 0;
  int activeCategoryPageIndex = 0;
  final itemKeys = <GlobalKey>[];
  late final ValueNotifier<int> activeTabNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      ref.read(langProvider.notifier).fetchLocale("en");
      getRestaurantMenus("136");
    });
  }

  void _scrollListener() {
    for (int i = 0; i < itemKeys.length; i++) {
      final keyContext = itemKeys[i].currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);

        print("${position.dy}");
        if (position.dy <= 222 && position.dy >= -box.size.height / 2) {
          activeTabNotifier.value = i;
          categoryTabController.animateTo(i);
          break;
        }
      }
    }
  }

  void scrollToCategory(int index) {
    final RenderBox renderBox =
        itemKeys[index].currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero,
        ancestor: context.findRenderObject());
    final offset = position.dy + scrollController.offset - 200;

    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appContext: context,
          title: "Menu",
          navigated: true,
          isCenter: false,
          appBarHeight: 50,
        ),
        body: Consumer(builder: (context, ref, child) {
          final fetchRestaurantState = ref.watch(fetchRestaurantMenuStateProvider);

          if (fetchRestaurantState.state == DataState.SUCCESS) {
            itemKeys.addAll(List.generate(
                fetchRestaurantState.data?.categoryItems?.length ?? 0,
                (_) => GlobalKey()));

            categoryTabController = TabController(
                length: fetchRestaurantState.data?.categoryItems?.length ?? 0,
                vsync: this);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 135,
                  child: ValueListenableBuilder<int>(
                    valueListenable: activeTabNotifier,
                    builder: (context, value, _) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TabBar(
                          isScrollable: true,
                          labelPadding: EdgeInsets.zero,
                          indicatorColor: Colors.transparent,
                          controller: categoryTabController,
                          onTap: (index) {
                            scrollToCategory(index);
                          },
                          tabs: (fetchRestaurantState.data?.categoryItems ?? [])
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return CategoryTabItem(
                              isSelected: value == index,
                              icon: burgerIcon,
                              categoryName: item.categoryName ?? "",
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: List.generate(
                              fetchRestaurantState
                                      .data?.categoryItems?.length ??
                                  0, (index) {
                            var cat = fetchRestaurantState
                                .data?.categoryItems?[index];
                            return Container(
                              key: itemKeys[index],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      cat?.categoryName ?? "",
                                      style: AppTheme
                                          .styleWithTextAppBlackColor3AdelleSansExtendedFonts20w500,
                                    ),
                                  ),
                                  ListView.separated(
                                      itemBuilder: (context, index) => Skeletonizer(
                                        enabled: fetchRestaurantState.state == DataState.LOADING,
                                        child: MealItem(
                                              meal: cat?.rsItemList?[index],
                                            ),
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const Divider(
                                            height: 1,
                                            color: AppTheme.gray,
                                          ),
                                      itemCount: cat?.rsItemList?.length ?? 0)
                                ],
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 135,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TabBar(
                      isScrollable: true,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: Colors.transparent,
                      controller: TabController(length: 8,vsync: this),
                      onTap: (index) {
                        scrollToCategory(index);
                      },
                      tabs: (["","","","","","","","",])
                          .asMap()
                          .entries
                          .map((entry) {
                        return const Skeletonizer(
                          enabled: true,
                          child: CategoryTabItem(
                            isSelected: false,
                            icon: "",
                            categoryName:  "",
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          const Skeletonizer(
                            enabled:true,
                            child: MealItem(),
                          ),
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                      const Divider(
                        height: 1,
                        color: AppTheme.gray,
                      ),
                      itemCount: 10),
                ),
              ],
            );
          }
        }));
  }

  void getRestaurantMenus(String restaurantId) {
    ref.read(fetchRestaurantMenuStateProvider.notifier).call(restaurantId: restaurantId);
  }
}
