// features/search/presentation/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/app_button.dart';
import 'package:flutter_base/features/home/persentaion/widget/search_with_filter.dart';
import 'package:flutter_base/features/search/presentation/screens/all_data_of_search_category_screen.dart';
import 'package:flutter_base/features/search/presentation/screens/search_result_screen.dart';
import 'package:flutter_base/features/search/presentation/widgets/search_item_list_when_exist_data.dart';
import 'package:flutter_base/features/search/presentation/widgets/search_screen_body_exict_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/eunms.dart';
import '../../../../core/widgets/svg_icons.dart';
import '../../../auth/presentation/providers/usecase_provider.dart';
import '../../../home/data/item_selector.dart';
import '../../../home/persentaion/Providers/FilterStateNotifiers.dart';
import '../../../home/persentaion/bottom_sheets/filter_bottom_sheet.dart';
import '../provider/resturant_use_case_provider.dart';
import '../widgets/intil_body_for_search_screen.dart';
import '../widgets/search_item_list_initil_body.dart';
import '../widgets/search_screen_body_not_exixt_data.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<FilterItemSelector> filterList = [];
  int? selectedSortByItemIndex;
  int? selectedCuisinesIndex;
  int? selectedRatingIndex;
  RangeValues? selectRangeValues;
  RangeValues? selectDistantRangeValues;
  List<Map<String, dynamic>> data = [
    {
      "title": "See all restaurants",
      "hasSubTitle": false,
      "iconPath": restaurantIcons,
      "subTitle": "",
    },
    {
      "title": "Offers",
      "hasSubTitle": true,
      "iconPath": discountIcon,
      "subTitle": "Eats&Beats Advantages",
    },
    {
      "title": "Best Rated",
      "hasSubTitle": true,
      "iconPath": ratingIcon,
      "subTitle": "Eats&Beats Recommendations",
    },
    {
      "title": "Italian",
      "hasSubTitle": true,
      "iconPath": reserveIcon,
      "subTitle": "Cuisine",
    }
  ];
 @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.code006060Color,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.code008080Color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SVGIcons.localSVG(
          mapIcon,
          width: 32,
          height: 32,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              padding: EdgeInsets.symmetric(
                horizontal: defaultPaddingHorizontal,
                vertical: 25,
              ),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.code006060Color,
                  AppTheme.code008080Color,
                ],
              )),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AppSearchBarWithFilter(
                  controller: searchController,
                  hasFilter: true,
                  enableSearch: true,
                  filterIconColor: AppTheme.appGrey15,
                  onFilterClick: () {
                    showFilterWithDistantBottomSheet();
                  },
                  onTextChangeListener: (p0) {
                    setState(() {});
                  },
                  hintTxt: "Search for restaurant, cuisines....",
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.whiteColor,
                ),
                child: searchController.text.isEmpty
                    ? IntilBodyForSearchScreen(data: data)
                    : data.length == 0
                        ? SearchScreenBodyExictData(data: data)
                        : SearchScreenBodyNotExixtData(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFilterWithDistantBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      context: context,
      builder: (BuildContext context) => FilterBottomSheet(
        hasDistant: true,
        initSortByItemIndex: selectedSortByItemIndex,
        initCuisinesIndex: selectedCuisinesIndex,
        initRatingIndex: selectedRatingIndex,
        initRatingValue: selectRangeValues,
        initDistantRatingValue: selectDistantRangeValues,
        onFilterApply: (sortByItemIndex, cuisinesIndex, ratingIndex,
            rangeValues, rangeDistantValue) {
          print("sortByItemIndex $sortByItemIndex \n"
              "cuisinesIndex $cuisinesIndex\n"
              "ratingIndex $ratingIndex\n"
              "rangeValues $rangeValues"
              "range Distant Value id  $rangeDistantValue");
          selectedSortByItemIndex = sortByItemIndex;
          selectedCuisinesIndex = cuisinesIndex;
          selectedRatingIndex = ratingIndex;
          selectRangeValues = rangeValues;
          selectDistantRangeValues = rangeDistantValue;
          ref.read(restaurantFilterProvider.notifier).updateStatue([]);
          filterList.clear();
          if (selectedSortByItemIndex != null) {
            filterList.add(sortByItems[selectedSortByItemIndex!]);
          }
          if (selectedCuisinesIndex != null) {
            // filterList.add(sortByItems[selectedSortByItemIndex]);
          }
          if (selectedRatingIndex != null) {
            filterList.add(ratings[selectedRatingIndex!]);
          }
          if (selectRangeValues != null) {
            filterList.add(FilterItemSelector(
                name: "${rangeValues?.start} - ${rangeValues?.end}",
                type: FilterType.Price));
          }
          if (selectDistantRangeValues != null) {
            filterList.add(FilterItemSelector(
                name: "${rangeDistantValue?.start} - ${rangeDistantValue?.end}",
                type: FilterType.Distant));
          }
          print(filterList.length);
          ref.read(restaurantFilterProvider.notifier).updateStatue(filterList);
          navigateToSearchScreen(
            filterList: filterList,
            selectDistantRangeValues: selectDistantRangeValues,
            selectedCuisinesIndex: selectedCuisinesIndex,
            selectedRatingIndex: selectedRatingIndex,
            selectedSortByItemIndex: selectedSortByItemIndex,
            selectRangeValues: selectRangeValues,
          );
        },

      ),
    );
  }

  void navigateToSearchScreen(
      {required List<FilterItemSelector> filterList,
      RangeValues? selectDistantRangeValues,
      int? selectedCuisinesIndex,
      int? selectedRatingIndex,
      int? selectedSortByItemIndex,
      RangeValues? selectRangeValues}) {
    context.push(searchScreenResultRoute,extra: {
      FILTER_LIST_KEY:filterList,
      SELECT_DISTANT_RANGE_VALUES_KEY:selectDistantRangeValues,
      SELECTED_SORT_BY_ITEM_INDEX_KEY:selectedSortByItemIndex,
      SELECT_CUISINES_INDEX_KEY:selectedCuisinesIndex,
      SELECT_RATING_INDEX_KEY:selectedRatingIndex,
      SELECT_RANGE_VALUE_KEY:selectRangeValues,
    });
  }
}
