import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/data/models/item_selector.dart';
import 'package:flutter_base/features/home/persentaion/widget/filter/filter_option_item.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/typedefs.dart';
import '../../../../core/widgets/app_button.dart';

class FilterBottomSheet extends StatefulWidget {
  final int? initSortByItemIndex;
  final int? initCuisinesIndex;
  final int? initRatingIndex;
  final RangeValues? initRatingValue;
  final bool? enableFilterByCuisine;
  final FilterResult onFilterApply;
  const FilterBottomSheet(
      {super.key,
      required this.onFilterApply,
      this.initSortByItemIndex,
      this.initCuisinesIndex,
      this.initRatingIndex, this.initRatingValue, this.enableFilterByCuisine});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues? selectRangeValues;
  int? selectedSortByItemIndex;
  int? selectedCuisinesIndex;
  int? selectedRatingIndex;
  final cuisines = [
    ItemSelector(
      id: 0,
      name: "Italian",
    ),
    ItemSelector(
      id: 1,
      name: "Mexican",
    ),
    ItemSelector(
      id: 2,
      name: "Western",
    ),
    ItemSelector(
      id: 3,
      name: "Eastern",
    ),
    ItemSelector(
      id: 4,
      name: "Chinese",
    ),
    ItemSelector(
      id: 5,
      name: "Indian",
    )
  ];

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
    print(
        "sortByItemIndex $selectedSortByItemIndex \n"
            "cuisinesIndex $selectedCuisinesIndex\n"
            "ratingIndex $selectedRatingIndex\n"
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    calculateCuisinesHeight();

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
                    state: selectedSortByItemIndex == sortByItems[index].id,
                    id: sortByItems[index].id,
                    optionName: sortByItems[index].name ?? "",
                    onItemSelect: (int) {
                      setState(() {
                        selectedSortByItemIndex = sortByItems[index].id;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),

            widget.enableFilterByCuisine == true?
            Column(
              children: [
                Text(
                  "Cuisines",
                  style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts16w700,
                ),
                SizedBox(
                  height: defaultPaddingHorizontal,
                ),
                SizedBox(
                  height: calculateCuisinesHeight(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, // 3 widgets per row
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: mainAxisSpacing,
                      childAspectRatio: childAspectRatio, // Adjust based on design
                    ),
                    itemCount: cuisines.length,
                    itemBuilder: (context, index) {
                      return FilterOptionItem(
                        state: selectedCuisinesIndex == cuisines[index].id,
                        id: cuisines[index].id,
                        optionName: cuisines[index].name ?? "",
                        onItemSelect: (int) {
                          setState(() {
                            selectedCuisinesIndex = cuisines[index].id;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ):const SizedBox(),
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
                        color: selectedRatingIndex == ratings[index].id
                            ? Colors.white
                            : Colors.orange,
                        width: 20,
                        height: 20),
                    state: selectedRatingIndex == ratings[index].id,
                    id: ratings[index].id,
                    optionName: ratings[index].name ?? "",
                    onItemSelect: (int) {
                      setState(() {
                        selectedRatingIndex = ratings[index].id;
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
                  "${selectRangeValues?.start.round()?? filterPriceStart} - ${selectRangeValues?.end.round() ?? filterPriceEnd}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            RangeSlider(
              values: selectRangeValues ?? const RangeValues(filterPriceStart, filterPriceEnd),
              min: 0,
              max: 100,
              divisions: 10, // Optional: Creates steps
              labels: RangeLabels(
                (selectRangeValues?.start.round()?? filterPriceStart).toString(),
                (selectRangeValues?.end.round() ?? filterPriceEnd).toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  selectRangeValues = values;
                });
              },
              activeColor: AppTheme.orangeAppColor, // Change active track color
              inactiveColor: Colors.grey[300], // Change inactive track color
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            AppButton(
                enabled: enableFilterBtu(),
                backColor: AppTheme.mainAppColor,
                width: double.infinity,
                height: 56,
                text: "Show Results",
                onPress: () {
                  widget.onFilterApply.call(
                      selectedSortByItemIndex,
                      selectedCuisinesIndex,
                      selectedRatingIndex,
                      selectRangeValues);
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

  double calculateCuisinesHeight() {
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
