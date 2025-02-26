import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/core/widgets/paginated_listview.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/data/item_selector.dart';
import 'package:flutter_base/features/home/persentaion/Providers/FilterStateNotifiers.dart';
import 'package:flutter_base/features/home/persentaion/widget/filter/horizontal_filter_result_listview.dart';
import 'package:flutter_base/features/home/persentaion/widget/restaurant_widgets/vertical_restaurant_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'bottom_sheets/filter_bottom_sheet.dart';
import 'widget/search_with_filter.dart';

class SeeAllScreenForCategory extends ConsumerStatefulWidget {
  const SeeAllScreenForCategory({super.key});

  @override
  ConsumerState<SeeAllScreenForCategory> createState() =>
      _SeeAllScreenForCategoryState();
}

class _SeeAllScreenForCategoryState extends ConsumerState<SeeAllScreenForCategory> {
  List<ItemSelector> filterList = [];
  @override
  Widget build(BuildContext context) {
    var filterResult = ref.watch(restaurantFilterProvider);

    print("filter result $filterResult");
    return Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        appBar: CustomAppBar(
          navigated: true,
          appContext: context,
          title: "Trending Now",
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingHorizontal),
              child: AppSearchBarWithFilter(
                hasFilter: true,
                enableSearch: true,
                onFilterClick: () {
                  showFilterBottomSheet();
                },
                hintTxt: "Type of food, restaurant name",
              ),
            ),
            SizedBox(
              height: filterResult.isNotEmpty ? 20 : 0,
            ),
            HorizontalFilterResultListview(list: filterResult),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: PaginatedListView(
                  dataList: [
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                  ],
                  scrollPhysics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  paginated: true,
                  builder: (item) => Skeletonizer(
                        enabled: false,
                        child: const VerticalRestaurantCard(),
                      )),
            )
          ],
        ));
  }

  void showFilterBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        context: context,
        builder: (BuildContext context) => FilterBottomSheet(
              onFilterApply: (selectedSortByItemIndex, selectedCuisinesIndex,
                  selectedRatingIndex, rangeValues) {
                filterList.clear();
                if(selectedSortByItemIndex != null){
                  filterList.add(sortByItems[selectedSortByItemIndex]);
                }
                if(selectedCuisinesIndex != null){
                  // filterList.add(sortByItems[selectedSortByItemIndex]);
                }
                if(selectedRatingIndex != null){
                  filterList.add(ratings[selectedRatingIndex]);
                }
                if(rangeValues != null){
                  filterList.add(
                    ItemSelector(
                      name: "${rangeValues.start} - ${rangeValues.end}"
                    )
                  );
                }
                print(
                  filterList.length
                );
                ref.read(restaurantFilterProvider.notifier).updateStatue(filterList);
              },
            ));
  }
}
