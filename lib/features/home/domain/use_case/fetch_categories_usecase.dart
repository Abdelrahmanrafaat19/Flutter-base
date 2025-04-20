import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/features/home/domain/entities/category_entity.dart';
import 'package:flutter_base/features/home/domain/entities/restaurant_entity.dart';
import 'package:flutter_base/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_base/features/location/domain/address_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../../data/models/category_model.dart';
import '../../data/models/location_model.dart';

class FetchCategoriesUseCase extends StateNotifier<StateModel<List<CategoryEntity>>> {
  final Ref ref;
  final HomeRepository _homeRepository;
  FetchCategoriesUseCase(this.ref, this._homeRepository) : super(StateModel());

  void call({
    String? page = "0",
    String? size = "10",
    String? localeIsoCode = "en",
    bool? fetchRestaurants = true,
    bool? featured = true,
    List<int>? categoryIds
  })
  async {
    state = StateModel.loading();

    final userLocation = await AddressStorage.getUserLocation();


    ResponseModel responseModel = await _homeRepository.fetchCategories(
      page: page,
      size: size,
      localeIsoCode: localeIsoCode,
      fetchRestaurants: fetchRestaurants,
      featured: featured,userLocation: userLocation
    );

    if (responseModel.code == 200) {
      List<CategoryEntity> categories= (responseModel.data as List)
      .map((item) => toCategoryEntity(CategoryModel.fromJson(item))).toList();
      state = StateModel(
          state: DataState.SUCCESS, data: categories, message: responseModel.message);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }

  void updateFavoriteRestaurantState(int id) {
    final categories = [...?state.data];

    final categoryIndex = categories.indexWhere((category) =>
    category.rsRestaurants?.any((restaurant) => restaurant.id == id) ?? false);

    if (categoryIndex != -1) {
      final category = categories[categoryIndex];
      final restaurants = [...?category.rsRestaurants];

      final restaurantIndex = restaurants.indexWhere((r) => r.id == id);
      if (restaurantIndex != -1) {
        final restaurant = restaurants[restaurantIndex];
        restaurants[restaurantIndex] =
            restaurant.copyWith(isFavorite: !(restaurant.isFavorite ?? false));

        categories[categoryIndex] =
            category.copyWith(rsRestaurants: restaurants);

        state = StateModel.success(categories);
      }
    }
  }
}
