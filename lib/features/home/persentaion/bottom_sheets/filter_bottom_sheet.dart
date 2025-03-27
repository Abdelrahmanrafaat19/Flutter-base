import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/data/models/item_selector.dart';
import 'package:flutter_base/features/home/domain/entities/cuisine_entity.dart';
import 'package:flutter_base/features/home/persentaion/Providers/usecase_provider.dart';
import 'package:flutter_base/features/home/persentaion/widget/filter/filter_option_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/typedefs.dart';
import '../../../../core/widgets/app_button.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  final int? initSortByItemIndex;
  final int? initCuisinesIndex;
  final int? initRatingIndex;
  final bool? hasDistant;
  final RangeValues? initRatingValue;
  final RangeValues? initDistantRatingValue;
  final FilterResult? onFilterApply;
  final FilterDistantResult? onFilterIsDistantApply;
  final Widget? screen;
  final bool? enableFilterByCuisine;

  const FilterBottomSheet({
    super.key,
    this.onFilterApply,
    this.initSortByItemIndex,
    this.initCuisinesIndex,
    this.initRatingIndex,
    this.initRatingValue,
    this.initDistantRatingValue,
    this.hasDistant = false,
    this.onFilterIsDistantApply,
    this.screen,
    this.enableFilterByCuisine,
  });

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  RangeValues? selectRangeValues;
  RangeValues? selectRangeDistantValues;
  int? selectedSortByItemIndex;
  int? selectedCuisinesIndex;
  int? selectedRatingIndex;

  int crossAxisCount = 3;
  double crossAxisSpacing = 20;
  double mainAxisSpacing = 20;
  double childAspectRatio = 2.5;
  double itemHeight = 47; // Example fixed height

  @override
  void initState() {
    selectedSortByItemIndex = widget.initSortByItemIndex;
    selectedCuisinesIndex = widget.initCuisinesIndex;
    selectedRatingIndex = widget.initRatingIndex;
    selectRangeValues = widget.initRatingValue;
    print("sortByItemIndex $selectedSortByItemIndex \n"
        "cuisinesIndex $selectedCuisinesIndex\n"
        "ratingIndex $selectedRatingIndex\n");
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      if (ref.watch(fetchAllCuisinesStateNotifierProvider).data == null) {
        ref.read(fetchAllCuisinesStateNotifierProvider.notifier).call(
            page: "0",
            size: "1000",
            localeIsoCode: /*ref.watch(langProvider).toString()*/ "en",
            featured: true,
            fetchRestaurants: false,
            cuisineIds: []);
      }
    });
    selectRangeDistantValues = widget.initDistantRatingValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cuisines = ref.watch(fetchAllCuisinesStateNotifierProvider);
    calculateCuisinesHeight(cuisines.data ?? []);

    return Padding(
      padding: const EdgeInsets.all(defaultPaddingHorizontal),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Filter",
                      style: AppTheme.styleColorAppGunmetal40FontSize20W700
                          .copyWith(decoration: TextDecoration.underline)),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedRatingIndex = null;
                      selectedCuisinesIndex = null;
                      selectedSortByItemIndex = null;
                      selectRangeValues =
                          const RangeValues(filterPriceStart, filterPriceEnd);
                      selectRangeDistantValues =
                          const RangeValues(filterPriceStart, filterPriceEnd);
                    });
                  },
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text("Reset",
                        style: AppTheme
                            .styleWithTextGray7AdelleSansExtendedFonts16w400),
                  ),
                )
              ],
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            Text(
              "Sort By",
              style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts16w700,
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            SizedBox(
              height: 60,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 widgets per row
                  crossAxisSpacing: 25,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: 2.5, // Adjust based on design
                ),
                itemCount: sortByItems.length,
                itemBuilder: (context, index) {
                  return FilterOptionItem(
                    state: selectedSortByItemIndex != null
                        ? sortByItems[selectedSortByItemIndex!].id ==
                            sortByItems[index].id
                        : false,
                    id: sortByItems[index].id,
                    optionName: sortByItems[index].name ?? "",
                    onItemSelect: (int) {
                      setState(() {
                        selectedSortByItemIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            widget.enableFilterByCuisine == true
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cuisines",
                        style: AppTheme
                            .styleWithTextBlackAdelleSansExtendedFonts16w700,
                      ),
                      SizedBox(
                        height: defaultPaddingHorizontal,
                      ),
                      SizedBox(
                        height: calculateCuisinesHeight(cuisines.data ?? []),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount, // 3 widgets per row
                            crossAxisSpacing: crossAxisSpacing,
                            mainAxisSpacing: mainAxisSpacing,
                            childAspectRatio:
                                childAspectRatio, // Adjust based on design
                          ),
                          itemCount: cuisines.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            var state = false ;
                            if (selectedCuisinesIndex != null ){
                              state = cuisines.data?[selectedCuisinesIndex!].id ==
                                  cuisines.data?[index].id ;
                            }
                            return FilterOptionItem(
                              state: state,
                              id: cuisines.data?[index].id,
                              optionName: cuisines.data?[index].name ?? "",
                              onItemSelect: (int) {
                                setState(() {
                                  selectedCuisinesIndex = index;
                                  print("asdfsdfsdfa $selectedCuisinesIndex");
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: defaultPaddingHorizontal,
            ),
            Divider(
              color: AppTheme.appGrey8,
              height: 1,
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            Text(
              "Rating",
              style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts16w700,
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            SizedBox(
              height: 60,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 3 widgets per row
                  crossAxisSpacing: 18,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: 1.45, // Adjust based on design
                ),
                itemCount: ratings.length,
                itemBuilder: (context, index) {
                  return FilterOptionItem(
                    icon: SVGIcons.localSVG(filterRatingStarIconPath,
                        color: selectedRatingIndex != null ?
                        ratings[selectedRatingIndex!].id == ratings[index].id
                            ? Colors.white
                            : Colors.orange : Colors.orange,
                        width: 20,
                        height: 20),
                    state: selectedRatingIndex != null ?
                    ratings[selectedRatingIndex!].id == ratings[index].id : false,
                    id: ratings[index].id,
                    optionName: ratings[index].name ?? "",
                    onItemSelect: (int) {
                      setState(() {
                        selectedRatingIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            Row(
              children: [
                Text(
                  "Price",
                  style:
                      AppTheme.styleWithTextBlackAdelleSansExtendedFonts16w700,
                ),
                Spacer(),
                Text(
                  "${selectRangeValues?.start.round() ?? filterPriceStart} - ${selectRangeValues?.end.round() ?? filterPriceEnd}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            RangeSlider(
              values: selectRangeValues ??
                  const RangeValues(filterPriceStart, filterPriceEnd),
              min: 0,
              max: 100,
              divisions: 10, // Optional: Creates steps
              labels: RangeLabels(
                (selectRangeValues?.start.round() ?? filterPriceStart)
                    .toString(),
                (selectRangeValues?.end.round() ?? filterPriceEnd).toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  selectRangeValues = values;
                });
              },
              activeColor: AppTheme.orangeAppColor,
              // Change active track color
              inactiveColor: Colors.grey[300], // Change inactive track color
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            widget.hasDistant == true
                ? Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Distance Range",
                            style: AppTheme
                                .styleWithTextBlackAdelleSansExtendedFonts16w700,
                          ),
                          Spacer(),
                          Text(
                            "${selectRangeDistantValues?.start.round() ?? filterPriceStart} KM - ${selectRangeDistantValues?.end.round() ?? filterPriceEnd} KM",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.orangeAppColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: defaultPaddingHorizontal,
                      ),
                      RangeSlider(
                        values: selectRangeDistantValues ??
                            const RangeValues(filterPriceStart, filterPriceEnd),
                        min: 0,
                        max: 100,
                        divisions: 10,
                        // Optional: Creates steps
                        labels: RangeLabels(
                          (selectRangeDistantValues?.start.round() ??
                                  filterPriceStart)
                              .toString(),
                          (selectRangeDistantValues?.end.round() ??
                                  filterPriceEnd)
                              .toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            selectRangeDistantValues = values;
                          });
                        },
                        activeColor: AppTheme.orangeAppColor,
                        // Change active track color
                        inactiveColor:
                            Colors.grey[300], // Change inactive track color
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height:
                  widget.hasDistant == true ? defaultPaddingHorizontal : 0.0,
            ),
            AppButton(
                enabled: enableFilterBtu(),
                backColor: AppTheme.mainAppColor,
                width: double.infinity,
                height: 56,
                text: "Show Results",
                onPress: () {
                  widget.onFilterApply?.call(
                    selectedSortByItemIndex,
                    selectedCuisinesIndex,
                    selectedRatingIndex,
                    selectRangeValues,
                    selectRangeDistantValues,
                  );

                  context.pop();
                }),
            SizedBox(
              height: defaultPaddingHorizontal,
            )
          ],
        ),
      ),
    );
  }

  double calculateCuisinesHeight(List<Cuisine> cuisines) {
    print("cuisines sizsadfse : ${cuisines.length}");
    if (cuisines.isEmpty) return 0;
    int rows = (cuisines.length / crossAxisCount).ceil();
    double totalHeight = (rows * itemHeight) + ((rows - 1) * mainAxisSpacing);
    return totalHeight;
  }

  bool enableFilterBtu() {
    return selectedSortByItemIndex != null ||
        selectedRatingIndex != null ||
        selectedCuisinesIndex != null ||
        (selectRangeValues?.start == filterPriceStart &&
            selectRangeValues?.end == filterPriceEnd);
  }
}
