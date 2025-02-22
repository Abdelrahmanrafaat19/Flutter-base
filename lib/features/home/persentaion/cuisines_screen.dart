import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import '../../../core/localization/Keys.dart';
import 'widget/category_widgets/restaurant_category.dart';

class CuisinesScreen extends StatelessWidget {
  const CuisinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: context.tr(cuisinesKey),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridView.builder(
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 9,
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.0379,
              childAspectRatio: 2 / 1.7),
          itemBuilder: (context, index) {
            return const RestaurantCategory(
              categoryImg:
                  "https://t3.ftcdn.net/jpg/02/52/38/80/360_F_252388016_KjPnB9vglSCuUJAumCDNbmMzGdzPAucK.jpg",
              categoryName: "sdfsadfs",
            );
          },
        ),
      ),
    );
  }
}
