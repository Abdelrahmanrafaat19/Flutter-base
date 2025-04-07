import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../repositories/restaurant_repo.dart';

class SearchOnRestaurantByNameUseCase
    extends StateNotifier<StateModel<List<String>>>{
  final Ref ref;
  final RestaurantRepo _repository;
  SearchOnRestaurantByNameUseCase(this.ref, this._repository) : super(StateModel());
  void call({
    int? page,
    int? size,
    String? localeIsoCode,
    String? searchText,
    int? cuisineId,
    int? categoryId,
    String? minRating,
    String?restaurantCertificates,
    bool? withRestaurants,
    bool? isOpen,
    bool? isSearchInMenu,
    int? itemID,
    String? itemName,
    String?dietaryTags,
    int? maxPrice,
    int? minPrice,
  }) async {



        StateModel(state: DataState.MORE_LOADING);


    // Build a request map and remove null values
    Map<String, dynamic> requestBody = {
      "searchText": searchText,
      "isOpen": isOpen,
      "minRating": minRating,
      "restaurantCertificates": restaurantCertificates,
      "cuisineId": cuisineId,
      "categoryId": categoryId,
      "searchInMenus": isSearchInMenu,
      "itemId":itemID,
      "itemName": itemName,
      "dietaryTags": dietaryTags,
      "maxPrice": maxPrice,
      "minPrice": minPrice
    }..removeWhere((key, value) => value == null); // Remove null values


    ResponseModel responseModel = await _repository.searchRestaurantByName(
        requestBody: requestBody);

    if (responseModel.code == 200) {
      List<String> restaurants = [...responseModel.data];

      state = StateModel(
          state: DataState.SUCCESS, data: restaurants, message: responseModel.message);

    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}