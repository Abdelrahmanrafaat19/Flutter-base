// features/search/presentation/widgets/search_screen_body_exict_data.dart
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_base/features/search/presentation/widgets/search_item_list_when_exist_data.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/constants/app_routes.dart';

class SearchScreenBodyExictData extends StatelessWidget {
  final List data;
  final bool enableLoading;
  const SearchScreenBodyExictData({super.key, required this.data, required this.enableLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      decoration: const BoxDecoration(
        color: AppTheme.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const   Text(
            "Search Results",
            style: AppTheme.style14W400code8088A4,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return SearchItemListWhenExistData(
                  enableLoading: enableLoading,
                  onTap: () {
                    context.push(searchScreenResultRoute,extra: {
                      SEARCH_TEXT:data[index]??"",
                    });
                  },
                  title: data[index]??"",
                  address: "85 elnasr street  Rd. elaml",
                  iconPath: restaurantIcons,
                  index: index,
                  listLength: data.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
