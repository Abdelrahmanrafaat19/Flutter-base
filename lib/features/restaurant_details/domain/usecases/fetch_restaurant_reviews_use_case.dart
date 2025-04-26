import 'package:flutter_base/core/models/ResponseModel.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/restaurant_details/data/models/ReviewModel.dart';
import 'package:flutter_base/features/restaurant_details/domain/entities/ReviewEntity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/restaurant_repository.dart';

class FetchRestaurantReviewsUseCase
    extends StateNotifier<StateModel<List<ReviewEntity>>> {
  final RestaurantRepository restaurantRepository;
  FetchRestaurantReviewsUseCase(this.restaurantRepository)
      : super(StateModel());

  void call(
      {String? restaurantId,
      String? localeIsoCode,
      String? page = "0",
      String? size = "5"}) async {
    state = StateModel.loading();
    ResponseModel responseModel =
        await restaurantRepository.fetchRestaurantReviews(
            restaurantId: restaurantId,
            localeIsoCode: "en",
            page: page,
            size: size);

    if (responseModel.code == 200) {
      List<ReviewEntity> reviews = (responseModel.data as List)
      .map((item) => ReviewModel.fromJson(item).toEntity()).toList() ?? [];

      state = StateModel(
          state: DataState.SUCCESS,
          data: reviews,
          message: responseModel.message);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          data: null,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}
