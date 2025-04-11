import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/features/home/domain/entities/category_entity.dart';
import 'package:flutter_base/features/home/domain/entities/restaurant_entity.dart';
import 'package:flutter_base/features/home/persentaion/widget/restaurant_widgets/horizontal_restaurant_listview_with_title.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/typedefs.dart';

class HomeRestaurantListview extends StatefulWidget {
  final List<CategoryEntity> restaurants;
  final bool showLoading;
  final OnRestaurantClick onChangeRestaurantState;

  const HomeRestaurantListview(
      {super.key, required this.restaurants, required this.showLoading,required this.onChangeRestaurantState});

  @override
  State<HomeRestaurantListview> createState() => _HomeRestaurantListviewState();
}

class _HomeRestaurantListviewState extends State<HomeRestaurantListview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...(List.generate(widget.restaurants.length, (index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 24),
            child: HorizontalRestaurantListWithTitle(
                categoryItem: widget.restaurants[index],
                showLoading: widget.showLoading,
                itemClick: onItemClick,
                onSeeAllClickListener: onSeeAllClickListener, onChangeRestaurantState: (restaurant) {
                  widget.onChangeRestaurantState.call(restaurant);
            },),
          );
        }))
      ],
    );
  }

  void onItemClick(Restaurant? restaurant) {}

  void onSeeAllClickListener(CategoryEntity category) {
    context.push(seeAllScreenForCategoryRoute, extra: {
      TITLE_KEY: category.description,
      CATEGORY_ID_KEY: category.id,
    });
  }

}
