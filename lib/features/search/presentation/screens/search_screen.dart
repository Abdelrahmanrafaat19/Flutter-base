// features/search/presentation/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/widgets/app_button.dart';
import 'package:flutter_base/features/home/persentaion/widget/search_with_filter.dart';
import 'package:flutter_base/features/search/presentation/widgets/search_item_list_when_exist_data.dart';
import 'package:flutter_base/features/search/presentation/widgets/search_screen_body_exict_data.dart';

import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/svg_icons.dart';
import '../widgets/intil_body_for_search_screen.dart';
import '../widgets/search_item_list_initil_body.dart';
import '../widgets/search_screen_body_not_exixt_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> data = [
    {
      "title": "See all restaurants",
      "hasSubTitle": false,
      "iconPath": restaurantIcons,
      "subTitle": ""
    },
    {
      "title": "Offers",
      "hasSubTitle": true,
      "iconPath": discountIcon,
      "subTitle": "Eats&Beats Advantages"
    },
    {
      "title": "Best Rated",
      "hasSubTitle": true,
      "iconPath": ratingIcon,
      "subTitle": "Eats&Beats Recommendations"
    },
    {
      "title": "Italian",
      "hasSubTitle": true,
      "iconPath": reserveIcon,
      "subTitle": "Cuisine"
    }
  ];
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
                  onFilterClick: () {},
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
}
