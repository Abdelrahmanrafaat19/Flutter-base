import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/eunms.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/paginated_listview.dart';

import '../../../home/data/models/item_selector.dart';

import '../../../home/persentaion/Providers/filter_state_notifiers.dart';
import '../../../home/persentaion/bottom_sheets/filter_bottom_sheet.dart';
import '../../../home/persentaion/widget/filter/horizontal_filter_result_listview.dart';
import '../../../home/persentaion/widget/restaurant_widgets/vertical_restaurant_card.dart';
import '../../../home/persentaion/widget/search_with_filter.dart';

class AllDataOfSearchCategoryScreen extends ConsumerStatefulWidget {
  final String title;

  const AllDataOfSearchCategoryScreen({super.key, required this.title});

  @override
  ConsumerState<AllDataOfSearchCategoryScreen> createState() =>
      _AllDataOfSearchCategoryScreenState();
}

class _AllDataOfSearchCategoryScreenState
    extends ConsumerState<AllDataOfSearchCategoryScreen> {
  final TextEditingController searchController = TextEditingController();
  List<FilterItemSelector> filterList = [];
  int? selectedSortByItemIndex;
  int? selectedCuisinesIndex;
  int? selectedRatingIndex;
  RangeValues? selectRangeValues;
  RangeValues? selectDistantRangeValues;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var filterResult = ref.watch(restaurantFilterProvider);
    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: widget.title,
        customCallBack: () {
          filterResult.clear();
          context.pop();
        },
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppSearchBarWithFilter(
                controller: searchController,
                hasFilter: true,
                enableSearch: true,
                // filterIconColor: AppTheme.appGrey15,
                onFilterClick: () {
                  showFilterWithDistantBottomSheet();
                },
                onTextChangeListener: (p0) {
                  setState(() {});
                },
                hintTxt: "Search for restaurant, cuisines....",
              ),
            ),
            filterResult.isNotEmpty
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(),
            filterResult.isNotEmpty
                ? HorizontalFilterResultListview(
                    list: filterResult,
                    onItemDelete: (item) {
                      if (item?.type == FilterType.Sort) {
                        selectedSortByItemIndex = null;
                      } else if (item?.type == FilterType.Rating) {
                        selectedRatingIndex = null;
                      } else if (item?.type == FilterType.Price) {
                        selectRangeValues = null;
                      } else if (item?.type == FilterType.Cuisines) {
                        selectedCuisinesIndex = null;
                      }
                      ref
                          .read(restaurantFilterProvider.notifier)
                          .deleteItem(item!);
                    },
                  )
                : const SizedBox(),
            SizedBox(
              height: 8,
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
                  builder: (item) => const Skeletonizer(
                        enabled: false,
                        child: VerticalRestaurantCard(),
                      )),
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
          onFilterApply: (sortByItemIndex, cuisinesIndex,
                  ratingIndex, rangeValues, rangeDistantValue) {
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
                print(filterList.length);
                ref
                    .read(restaurantFilterProvider.notifier)
                    .updateStatue(filterList);
              },
            ));
  }
}
