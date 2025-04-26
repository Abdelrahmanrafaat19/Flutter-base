import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/meal_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/Theme/app_theme.dart';
import '../providers/use_case_provider.dart';

class CategoryTabContent extends StatelessWidget {
  final int index;
  const CategoryTabContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var restaurantMenu = ref.watch(fetchLimitRestaurantMenuItemsStateProvider);
      if(restaurantMenu.state == DataState.SUCCESS) {
        var categories = restaurantMenu.data?.categoryItems ?? [];
        var meals = categories[index].rsItemList;
        return ListView.separated(
          physics:
          const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: meals?.length ?? 0,
          itemBuilder: (context, i) {
            var meal = meals?[i];
            return MealItem(meal: meal);
          },
          separatorBuilder: (context, index) =>
          const Divider(
            height: 1,
            color: AppTheme.gray,
          ),
        );
      } return const SizedBox();
    });
  }
}
