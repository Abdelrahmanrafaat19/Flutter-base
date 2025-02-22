import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../title_with_see_all.dart';
import 'horizontal_restaurant_card.dart';

class HorizontalRestaurantListWithTitle extends StatefulWidget {
  final List<String> list;
  final bool showLoading;
  final VoidCallback itemClick;
  final VoidCallback onSeeAllClickListener;
  const HorizontalRestaurantListWithTitle(
      {super.key,
      required this.list,
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
        child: TitleWithSeeAll(
          title: "Trending Now",
          onClickOnSeeAll: () {
            widget.onSeeAllClickListener.call();
          },
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
                  child: HorizontalRestaurantCard(),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  width: 12,
                ),
            itemCount: widget.showLoading ? 5 : widget.list.length),
      ),
    ]);
  }
}
