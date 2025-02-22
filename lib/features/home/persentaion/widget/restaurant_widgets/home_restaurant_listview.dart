import 'package:flutter/cupertino.dart';
import 'package:flutter_base/features/home/persentaion/widget/restaurant_widgets/horizontal_restaurant_listview_with_title.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';

class HomeRestaurantListview extends StatefulWidget {
  final List<String> restaurants;
  final bool showLoading;

  const HomeRestaurantListview(
      {super.key, required this.restaurants, required this.showLoading});

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
                list: ["", "", ""],
                showLoading: widget.showLoading,
                itemClick: onItemClick,
                onSeeAllClickListener: onSeeAllClickListener),
          );
        }))
      ],
    );
  }

  void onItemClick() {}

  void onSeeAllClickListener() {
    context.push(seeAllScreenForCategoryRoute);
  }
}
