import 'package:flutter_base/features/common/domain/repositories/common_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../../../home/domain/entities/restaurant_entity.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';

class RestaurantSearchUseCase
    extends StateNotifier<StateModel<List<RestaurantSummaryEntity>>> {
  final Ref ref;
  final CommonRepository _repository;
  RestaurantSearchUseCase(this.ref, this._repository) : super(StateModel());

  void call({
    int? page,
    String? size,
    String? localeIsoCode,
    String? restaurant,
    int? cuisineId,
    int? categoryId,
    String? minRating,
    bool? withRestaurants,
    bool? isOpen,
    bool? isSearchInMenu,
  }) async {

    if (state.pagination?.lastPage != null &&
        (page??0) > (state.pagination?.lastPage ?? 0)) return;

    state = page != 0
        ? StateModel(data: state.data, state: DataState.MORE_LOADING)
        : StateModel.loading();

    // Build a request map and remove null values
    Map<String, dynamic> requestBody = {
      "restaurant": restaurant,
      "categoryId": categoryId,
      "cuisineId": cuisineId,
      "minRating": minRating,
      "withRestaurants": withRestaurants,
      "isOpen": isOpen,
      "searchInMenus": isSearchInMenu,
    }..removeWhere((key, value) => value == null); // Remove null values

    print(requestBody);
    ResponseModel responseModel = await _repository.restaurantSearch(
        page: page.toString(),
        size: size,
        localeIsoCode: localeIsoCode,
        requestBody: requestBody);

    if (responseModel.code == 200) {
      List<RestaurantSummaryEntity> restaurants = (responseModel.data as List)
          .map((item) => RestaurantModel.fromJson(item).toRestaurantSummaryEntity())
          .toList();

      if ((page??0) > 0) {
        List<RestaurantSummaryEntity> list = state.data ??[];
        list = [...list,...restaurants];

        state = StateModel.success(list,paginationModel: responseModel.pagination);
      }else{
        state = StateModel(
            state: DataState.SUCCESS,
            data: restaurants,
            message: responseModel.message,pagination: responseModel.pagination);
      }

    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
  void updateFavoriteRestaurantState(int id) {
    final restaurants = [...?state.data];

      final restaurantIndex = restaurants.indexWhere((res) => res.id == id);
      print(restaurantIndex);
      if (restaurantIndex != -1) {
        final restaurant = restaurants[restaurantIndex];
        restaurants[restaurantIndex] =
            restaurant.copyWith(isFavorite: !(restaurant.isFavorite ?? false));


        state = StateModel.success(restaurants);
      }

  }

}
