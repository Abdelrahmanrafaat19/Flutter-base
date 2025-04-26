import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/meal_item.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/review_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/app_routes.dart';
import '../providers/use_case_provider.dart';

class ReviewsContent extends StatefulWidget {
  final bool showAll;
  final String? restaurantId;
  const ReviewsContent({super.key, this.showAll = false, this.restaurantId});

  @override
  State<ReviewsContent> createState() => _ReviewsContentState();
}

class _ReviewsContentState extends State<ReviewsContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var restaurantReview = widget.showAll
          ? ref.watch(fetchRestaurantReviewsUseCaseStateProvider)
          : ref.watch(fetchRestaurantLimitReviewsUseCaseStateProvider);
      if (restaurantReview.state == DataState.SUCCESS) {
        var reviews = restaurantReview.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.showAll == false && restaurantReview.data?.isNotEmpty == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 1,
                        color: AppTheme.appGrey2,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Reviews",
                        style: AppTheme
                            .styleWithTextAppBlueColor3SansExtendedFonts16w700,
                      ),
                    ],
                  )
                : SizedBox(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reviews.length ?? 0,
              itemBuilder: (context, i) {
                var review = reviews[i];
                return Skeletonizer(
                    enabled: restaurantReview.state == DataState.LOADING,
                    child: ReviewItem(review: review));
              },
            ),
            widget.showAll == false && restaurantReview.data?.isNotEmpty == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                        child: InkWell(
                      onTap: () {
                        navigateToReviewsScreen();
                      },
                      child: Text(
                        "Show all Reviews",
                        style: AppTheme
                            .styleWithTextMainAppColorCeraProFonts14w500
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    )),
                  )
                : const SizedBox(),
          ],
        );
      }
      return const SizedBox();
    });
  }

  void navigateToReviewsScreen() {
    context.push(restaurantReviewsRoute,
        extra: {RESTAURANT_ID_KEY: widget.restaurantId.toString()});
  }
}
