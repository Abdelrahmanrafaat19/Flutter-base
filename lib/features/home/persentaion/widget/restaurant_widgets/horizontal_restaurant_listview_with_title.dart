import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/features/home/domain/entities/category_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../title_with_see_all.dart';
import 'horizontal_restaurant_card.dart';

class HorizontalRestaurantListWithTitle extends StatefulWidget {
  final CategoryEntity categoryItem;
  final bool showLoading;
  final VoidCallback itemClick;
  final VoidCallback onSeeAllClickListener;
  const HorizontalRestaurantListWithTitle(
      {super.key,
      required this.categoryItem,
      required this.showLoading,
      required this.itemClick,
      required this.onSeeAllClickListener});

  @override
  State<HorizontalRestaurantListWithTitle> createState() =>
      _HorizontalRestaurantListWithTitleState();
}

class _HorizontalRestaurantListWithTitleState
    extends State<HorizontalRestaurantListWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Skeletonizer(
        enabled: widget.showLoading,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal),
          child: TitleWithSeeAll(
            title: widget.categoryItem.description ?? "",
            onClickOnSeeAll: () {
              widget.onSeeAllClickListener.call();
            },
          ),
        ),
      ),
      SizedBox(
        height: 24,
      ),
      SizedBox(
        height: 215,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Skeletonizer(
                enabled: widget.showLoading,
                child: InkWell(
                  onTap: () {
                    widget.itemClick.call();
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: defaultPaddingHorizontal),
                    child: HorizontalRestaurantCard(
                      restaurant: widget.categoryItem.rsRestaurants?[index],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  width: 0,
                ),
            itemCount: widget.showLoading
                ? 5
                : widget.categoryItem.rsRestaurants?.length ?? 0),
      ),
    ]);
  }
}
