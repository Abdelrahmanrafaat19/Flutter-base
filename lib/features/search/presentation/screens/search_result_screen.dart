// features/search/presentation/screens/search_result_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/eunms.dart';
import '../../../../core/models/StateModel.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/paginated_listview.dart';
import '../../../common/presentation/providers/usecases_providers.dart';
import '../../../home/data/models/item_selector.dart';
import '../../../home/domain/entities/cuisine_entity.dart';
import '../../../home/domain/entities/restaurant_entity.dart';
import '../../../home/persentaion/Providers/filter_state_notifiers.dart';
import '../../../home/persentaion/Providers/usecase_provider.dart';
import '../../../home/persentaion/bottom_sheets/filter_bottom_sheet.dart';
import '../../../home/persentaion/widget/filter/horizontal_filter_result_listview.dart';
import '../../../home/persentaion/widget/restaurant_widgets/vertical_restaurant_card.dart';
import '../../../home/persentaion/widget/search_with_filter.dart';
import '../widgets/food_item_list.dart';
import '../widgets/search_screen_body_not_exixt_data.dart';

class SearchResultScreen extends ConsumerStatefulWidget {
  List<FilterItemSelector>? filterList;
  String? searchText;

  int? selectedSortByItemIndex;
  int? selectedCuisinesIndex;
  int? selectedRatingIndex;
  RangeValues? selectRangeValues;
  RangeValues? selectDistantRangeValues;
  final int? categoryId;
  final int? cuisineId;



  SearchResultScreen( {
    super.key,
     this.filterList,
     this.selectDistantRangeValues,
     this.selectedCuisinesIndex,
     this.selectedRatingIndex,
     this.selectedSortByItemIndex,
     this.selectRangeValues,
    this.categoryId,
    this.cuisineId,
    this.searchText,
  });

  @override
  ConsumerState<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends ConsumerState<SearchResultScreen> {
  late  TextEditingController searchController ;

  int? sortByItemIndex;
  String? searchValue;
  int page = 0;

  List<Cuisine> cuisines = [];
  void initState() {
    searchController=TextEditingController(text: widget.searchText);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      cuisines.clear();
      var cuisinesList = ref.read(fetchAllCuisinesStateNotifierProvider);
      cuisines = cuisinesList.data ?? [];
      fetchRestaurants(page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var filterResult = ref.watch(restaurantFilterProvider);
    var restaurantsResult = ref.watch(restaurantSearchProvider);

    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: "Search Result",
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
                  showFilterBottomSheet();

                },
                onTextChangeListener: (value) {
                  searchValue = value;
                  page = 0;
                  fetchRestaurants(page);
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
                  widget.selectedSortByItemIndex = null;
                } else if (item?.type == FilterType.Rating) {
                  widget.selectedRatingIndex = null;
                } else if (item?.type == FilterType.Price) {
                  widget.selectRangeValues = null;
                } else if (item?.type == FilterType.Cuisines) {
                  widget.selectedCuisinesIndex = null;
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
              child: !(restaurantsResult.data?.isEmpty == true &&
                  restaurantsResult.state == DataState.SUCCESS)
                  ? PaginatedListView<Restaurant>(
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
                    enabled:
                    restaurantsResult.state == DataState.LOADING,
                    child: Column(
                      children: [
                        VerticalRestaurantCard(restaurant: item),
                        Container(
                          width: double.infinity,
                          height: 170,
                          padding: EdgeInsets.only(
                            top: 9,
                          ),
                          child: PaginatedListView(
                            padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
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
                              scrollPhysics:
                              const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              paginated: true,
                              builder: (item) => Skeletonizer(
                                enabled: false,
                                child: FoodItemList(),
                              )),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 16,
                            bottom: 10,
                          ),
                          child: Divider(
                            height: 2,
                            color: AppTheme.appGrey8,
                          ),
                        )
                      ],
                    ),
                  ))
                  : const SearchScreenBodyNotExixtData(
                withBtu: false,
              ),
            )



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
          initSortByItemIndex: widget.selectedSortByItemIndex,
          initCuisinesIndex: widget.selectedCuisinesIndex,
          initRatingIndex:widget. selectedRatingIndex,
          initRatingValue: widget.selectRangeValues,
          initDistantRatingValue: widget.selectDistantRangeValues,
          onFilterApply: (sortByItemIndex, cuisinesIndex,
              ratingIndex, rangeValues, rangeDistantValue) {
            print("sortByItemIndex $sortByItemIndex \n"
                "cuisinesIndex $cuisinesIndex\n"
                "ratingIndex $ratingIndex\n"
                "rangeValues $rangeValues"
                "range Distant Value id  $rangeDistantValue");
            widget. selectedSortByItemIndex = sortByItemIndex;
            widget.selectedCuisinesIndex = cuisinesIndex;
            widget.selectedRatingIndex = ratingIndex;
            widget. selectRangeValues = rangeValues;
            widget. selectDistantRangeValues = rangeDistantValue;
            ref.read(restaurantFilterProvider.notifier).updateStatue([]);
            widget. filterList!.clear();
            if (widget.selectedSortByItemIndex != null) {
              widget.filterList!.add(sortByItems[widget.selectedSortByItemIndex!]);
            }
            if (widget.selectedCuisinesIndex != null) {
               widget.filterList!.add(sortByItems[widget.selectedSortByItemIndex!]);
            }
            if (widget.selectedRatingIndex != null) {
              widget.filterList!.add(ratings[widget.selectedRatingIndex!]);
            }
            if (widget.selectRangeValues != null) {
              widget.filterList!.add(FilterItemSelector(
                  name: "${rangeValues?.start} - ${rangeValues?.end}",
                  type: FilterType.Price));
            }
            if (widget.selectDistantRangeValues != null) {
              widget.filterList!.add(FilterItemSelector(
                  name:
                  "${rangeDistantValue?.start} - ${rangeDistantValue?.end}",
                  type: FilterType.Distant));
            }
            print(widget.filterList!.length);
            ref
                .read(restaurantFilterProvider.notifier)
                .updateStatue(widget.filterList!);
            page = 0;
            fetchRestaurants(page);
          },
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
          hasDistant: true,
          enableFilterByCuisine: widget.cuisineId == null,
          initSortByItemIndex: widget.selectedSortByItemIndex,
          initCuisinesIndex: widget.selectedCuisinesIndex,
          initRatingIndex: widget.selectedRatingIndex,
          initRatingValue: widget.selectRangeValues,
          onFilterApply: (sortByItemIndex, cuisinesIndex, ratingIndex,
              rangeValues, valueDistant) {
            print("sortByItemIndex $sortByItemIndex \n"
                "cuisinesIndex $cuisinesIndex\n"
                "ratingIndex $ratingIndex\n"
                "rangeValues $rangeValues");
            widget.selectedSortByItemIndex = sortByItemIndex;
            widget.selectedCuisinesIndex = cuisinesIndex;
            widget.selectedRatingIndex = ratingIndex;
            widget.selectRangeValues = rangeValues;
            ref.read(restaurantFilterProvider.notifier).updateStatue([]);
            widget.filterList!.clear();
            if (widget.selectedSortByItemIndex != null) {
              widget.filterList!.add(sortByItems[widget.selectedSortByItemIndex!]);
            }
            if (widget.selectedCuisinesIndex != null) {
              widget.filterList!.add(FilterItemSelector(
                  id: cuisines[widget.selectedCuisinesIndex!].id,
                  name: cuisines[widget.selectedCuisinesIndex!].name,
                  type: FilterType.Cuisines));
            }
            if (widget.selectedRatingIndex != null) {
              widget.filterList!.add(ratings[widget.selectedRatingIndex!]);
            }
            if (widget.selectRangeValues != null) {
              widget. filterList!.add(FilterItemSelector(
                  name: "${rangeValues?.start} - ${rangeValues?.end}",
                  type: FilterType.Price,));
            }
            print(widget.filterList!.length);
            ref
                .read(restaurantFilterProvider.notifier)
                .updateStatue(widget.filterList!);
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
        restaurant: widget.searchText/*searchValue?.isNotEmpty == true ? searchValue : null*/,
        cuisineId: widget.cuisineId ??
            (widget.selectedCuisinesIndex != null
                ? cuisines[widget.selectedCuisinesIndex!].id
                : null),
        minRating: widget.selectedRatingIndex != null
            ? ratings[widget.selectedRatingIndex!].name.toString()
            : null);
  }
}
/*
*
*
*   Expanded(
              child: PaginatedListView(
                  dataList: [
                    Restaurant(),
                    Restaurant(),
                    Restaurant(),
                    Restaurant(),
                    Restaurant(),
                  ],
                  scrollPhysics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  paginated: true,
                  builder: (item) => Skeletonizer(
                        enabled: false,
                        child: Column(
                          children: [
                            VerticalRestaurantCard(
                                restaurant: item
                            ),
                            Container(
                              width: double.infinity,
                              height: 170,
                              padding: EdgeInsets.only(
                                top: 9,
                              ),
                              child: PaginatedListView(
                                  scrollDirection: Axis.horizontal,
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
                                  scrollPhysics:
                                      const AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics()),
                                  paginated: true,
                                  builder: (item) => Skeletonizer(
                                        enabled: false,
                                        child: FoodItemList(),
                                      )),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 16,
                                left: 16,
                                right: 16,
                                bottom: 10,
                              ),
                              child: Divider(
                                height: 2,
                                color: AppTheme.appGrey8,
                              ),
                            )
                          ],
                        ),
                      )),
            )*/