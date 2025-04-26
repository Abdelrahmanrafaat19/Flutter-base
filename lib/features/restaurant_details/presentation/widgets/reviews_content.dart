import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/meal_item.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/review_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Theme/app_theme.dart';
import '../providers/use_case_provider.dart';

class ReviewsContent extends StatelessWidget {
  final bool showAll;
  const ReviewsContent({super.key, this.showAll = false});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var restaurantReview = showAll ? ref.watch(fetchRestaurantReviewsUseCaseStateProvider) : ref.watch(fetchRestaurantLimitReviewsUseCaseStateProvider);
      if(restaurantReview.state == DataState.SUCCESS) {
        var reviews = restaurantReview.data ?? [];
        return ListView.builder(
          physics:
          const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: reviews.length ?? 0,
          itemBuilder: (context, i) {
            var review = reviews[i];
            return Skeletonizer(
                enabled: restaurantReview.state == DataState.LOADING,
                child: ReviewItem(review: review));
          },
        );
      } return const SizedBox();
    });
  }
}
