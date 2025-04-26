import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/localization/LanguageProvider.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/features/restaurant_details/presentation/providers/use_case_provider.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/meal_item.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/review_item.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/reviews_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';


class RestaurantReviewsScreen extends ConsumerStatefulWidget {
  final String restaurantId;
  const RestaurantReviewsScreen({super.key,required this.restaurantId});
  @override
   _RestaurantReviewsState createState() => _RestaurantReviewsState();
}

class _RestaurantReviewsState extends ConsumerState<RestaurantReviewsScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      ref.read(langProvider.notifier).fetchLocale("en");
      getRestaurantReviews(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appContext: context,
          title: "Reviews",
          navigated: true,
          isCenter: false,
          appBarHeight: 80,
        ),
        body: const Expanded(
          child: ReviewsContent(showAll: true),
        ));
  }

  void getRestaurantReviews(String restaurantId) {
    ref.read(fetchRestaurantReviewsUseCaseStateProvider.notifier).call(restaurantId: "136",size: "1000");
  }
}
