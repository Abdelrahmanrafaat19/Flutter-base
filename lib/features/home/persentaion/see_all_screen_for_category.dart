import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/constants/eunms.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/core/widgets/paginated_listview.dart';
import 'package:flutter_base/features/home/data/models/item_selector.dart';
import 'package:flutter_base/features/home/domain/entities/cuisine_entity.dart';
import 'package:flutter_base/features/home/domain/entities/restaurant_entity.dart';
import 'package:flutter_base/features/home/persentaion/Providers/filter_state_notifiers.dart';
import 'package:flutter_base/features/home/persentaion/widget/filter/horizontal_filter_result_listview.dart';
import 'package:flutter_base/features/home/persentaion/widget/restaurant_widgets/vertical_restaurant_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/models/StateModel.dart';
import '../../common/presentation/providers/usecases_providers.dart';
import 'Providers/usecase_provider.dart';
import 'bottom_sheets/filter_bottom_sheet.dart';
import 'widget/search_with_filter.dart';

class SeeAllScreenForCategory extends ConsumerStatefulWidget {
  final String? title;
  final int? cuisineId;
  final int? categoryId;
  const SeeAllScreenForCategory({
    super.key,
    this.title,
    this.cuisineId,
    this.categoryId,
  });

  @override
  ConsumerState<SeeAllScreenForCategory> createState() =>
      _SeeAllScreenForCategoryState();
}

class _SeeAllScreenForCategoryState
    extends ConsumerState<SeeAllScreenForCategory> {
  List<FilterItemSelector> filterList = [];
  int? selectedSortByItemIndex;
  int? selectedCuisinesIndex;
  int? selectedRatingIndex;
  RangeValues? selectRangeValues;
  String? searchValue;
  int page = 0;
  List<Cuisine> cuisines = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      cuisines.clear();
      var cuisinesList = ref.read(fetchAllCuisinesStateNotifierProvider);
      cuisines = cuisinesList.data??[];
      fetchRestaurants(page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var filterResult = ref.watch(restaurantFilterProvider);
    var restaurantsResult = ref.watch(restaurantSearchProvider);

    return Scaffold(
        backgroundColor: const Color(0xffFAFAFA),
        appBar: CustomAppBar(
          navigated: true,
          appContext: context,
          title: widget.title,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingHorizontal),
              child: AppSearchBarWithFilter(
                hasFilterData: filterResult.isNotEmpty,
                hasFilter: true,
                enableSearch: true,
                onFilterClick: () {
                  showFilterBottomSheet();
                },
                hintTxt: "Type of food, restaurant name",
                delay: 1,
                onTextChangeListener: (value) {
                  searchValue = value;
                  page = 0;
                  fetchRestaurants(page);
                },
              ),
            ),
            SizedBox(
              height: filterResult.isNotEmpty ? 20 : 0,
            ),
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
                      page = 0;
                      fetchRestaurants(page);
                    },
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PaginatedListView<Restaurant>(
                  dataList: restaurantsResult.data ??
                      [
                        Restaurant(),
                        Restaurant(),
                        Restaurant(),
                        Restaurant(),
                        Restaurant(),
                      ],
                  scrollPhysics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  paginated: true,
                  pageLoading:
                      restaurantsResult.state == DataState.MORE_LOADING,
                  onBottomReached: () {
                    fetchRestaurants(++page);
                  },
                  builder: (item) => Skeletonizer(
                        enabled: restaurantsResult.state == DataState.LOADING,
                        child: VerticalRestaurantCard(
                          restaurant: item
                        ),
                      )),
            )
          ],
        ));
  }

  void showFilterBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        context: context,
        builder: (BuildContext context) => FilterBottomSheet(
              enableFilterByCuisine: widget.cuisineId == null,
              initSortByItemIndex: selectedSortByItemIndex,
              initCuisinesIndex: selectedCuisinesIndex,
              initRatingIndex: selectedRatingIndex,
              initRatingValue: selectRangeValues,
              onFilterApply:
                  (sortByItemIndex, cuisinesIndex, ratingIndex, rangeValues) {
                debugPrint("sortByItemIndex $sortByItemIndex \n"
                    "cuisinesIndex $cuisinesIndex\n"
                    "ratingIndex $ratingIndex\n"
                    "rangeValues $rangeValues");
                selectedSortByItemIndex = sortByItemIndex;
                selectedCuisinesIndex = cuisinesIndex;
                selectedRatingIndex = ratingIndex;
                selectRangeValues = rangeValues;
                ref.read(restaurantFilterProvider.notifier).updateStatue([]);
                filterList.clear();
                if (selectedSortByItemIndex != null) {
                  filterList.add(sortByItems[selectedSortByItemIndex!]);
                }
                if (selectedCuisinesIndex != null) {
                  filterList.add(
                      FilterItemSelector(
                        id: cuisines[selectedCuisinesIndex!].id,
                        name: cuisines[selectedCuisinesIndex!].name,
                        type: FilterType.Cuisines
                      )
                  );
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
                page = 0;
                fetchRestaurants(page);
              },
            ));
  }

  void fetchRestaurants(int page) {
    ref.read(restaurantSearchProvider.notifier).call(
        page: page,
        localeIsoCode: "en",
        size: 10.toString(),
        categoryId: widget.categoryId,
        restaurant: searchValue?.isNotEmpty == true ? searchValue : null,
        cuisineId: widget.cuisineId ?? selectedCuisinesIndex,
        minRating: selectedRatingIndex?.toString());
  }
}
