import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/meal_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/app_routes.dart';
import '../providers/use_case_provider.dart';

class CategoryTabContent extends StatefulWidget {
  final int index;
  final String? restaurantId;
  const CategoryTabContent({super.key, required this.index, this.restaurantId});

  @override
  State<CategoryTabContent> createState() => _CategoryTabContentState();
}

class _CategoryTabContentState extends State<CategoryTabContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var restaurantMenu =
          ref.watch(fetchLimitRestaurantMenuItemsStateProvider);
      if (restaurantMenu.state == DataState.SUCCESS) {
        var categories = restaurantMenu.data?.categoryItems ?? [];
        var meals = categories[widget.index].rsItemList;
        return Column(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: meals?.length ?? 0,
              itemBuilder: (context, i) {
                var meal = meals?[i];
                return MealItem(meal: meal);
              },
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: AppTheme.gray,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                  child: InkWell(
                onTap: () {
                  navigateToMenuScreen();
                },
                child: Text(
                  "Show all Menu",
                  style: AppTheme.styleWithTextMainAppColorCeraProFonts14w500
                      .copyWith(decoration: TextDecoration.underline),
                ),
              )),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Divider(
                thickness: 1,
                color: AppTheme.appGrey2,
              ),
            )
          ],
        );
      }
      return const SizedBox();
    });
  }

  void navigateToMenuScreen() {
    context.push(menuScreenRoute,
        extra: {RESTAURANT_ID_KEY: widget.restaurantId.toString()});
  }
}
