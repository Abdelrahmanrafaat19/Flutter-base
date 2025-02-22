import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/data/item_selector.dart';
import 'package:flutter_base/features/home/persentaion/widget/filter_option_item.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/widgets/app_button.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);

  int? selectedSortByItem;
  final sortByItems = [
    ItemSelector(
      id: 0,
      name: "All",
    ),
    ItemSelector(
      id: 1,
      name: "Newest",
    ),
    ItemSelector(
      id: 2,
      name: "Popular",
    ),
  ];
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
    ),
  ];
  final ratings = [
    ItemSelector(
      id: 0,
      name: "1",
    ),
    ItemSelector(
      id: 1,
      name: "2",
    ),
    ItemSelector(
      id: 2,
      name: "3",
    ),
    ItemSelector(
      id: 3,
      name: "4",
    ),
    ItemSelector(
      id: 4,
      name: "5",
    ),
  ];

  int crossAxisCount = 3;
  double crossAxisSpacing = 20;
  double mainAxisSpacing = 20;
  double childAspectRatio = 2.5;
  double itemHeight = 46; // Example fixed height


  @override
  Widget build(BuildContext context) {

    // Calculate number of rows
    int rows = (cuisines.length / crossAxisCount).ceil();
    double totalHeight = (rows * itemHeight) + ((rows - 1) * mainAxisSpacing);

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
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text("Reset",
                      style: AppTheme
                          .styleWithTextGray7AdelleSansExtendedFonts16w400),
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
                    state: selectedSortByItem == sortByItems[index].id,
                    id: sortByItems[index].id,
                    optionName: sortByItems[index].name ?? "",
                    onItemSelect: (int) {
                      setState(() {
                        selectedSortByItem = sortByItems[index].id;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            Text(
              "Cuisines",
              style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts16w700,
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            SizedBox(
              height: totalHeight,
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
                    state: selectedSortByItem == cuisines[index].id,
                    id: cuisines[index].id,
                    optionName: cuisines[index].name ?? "",
                    onItemSelect: (int) {
                      setState(() {
                        selectedSortByItem = cuisines[index].id;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
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
                    icon: SVGIcons.localSVG(
                        filterRatingStarIconPath,
                        color: selectedSortByItem == ratings[index].id
                            ? Colors.white
                            : Colors.orange,
                        width: 20,height: 20),
                    state: selectedSortByItem == ratings[index].id,
                    id: ratings[index].id,
                    optionName: ratings[index].name ?? "",
                    onItemSelect: (int) {
                      setState(() {
                        selectedSortByItem = ratings[index].id;
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
                  "Rating",
                  style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts16w700,
                ),
                Spacer(),
                Text(
                  "${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 100,
              divisions: 10, // Optional: Creates steps
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
              activeColor: AppTheme.orangeAppColor, // Change active track color
              inactiveColor: Colors.grey[300], // Change inactive track color
            ),
            SizedBox(
              height: defaultPaddingHorizontal,
            ),
            AppButton(
                backColor: AppTheme.mainAppColor,
                width: double.infinity,
                height: 56,
                text: "Show Results",
                onPress: () {
        
                }),
            SizedBox(
              height: defaultPaddingHorizontal,
            )
          ],
        ),
      ),
    );
  }
}
