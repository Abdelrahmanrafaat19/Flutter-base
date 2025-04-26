import 'package:flutter_base/core/models/ResponseModel.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/restaurant_details/data/models/menu_model.dart';
import 'package:flutter_base/features/restaurant_details/domain/entities/menu_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/restaurant_repository.dart';

class FetchRestaurantMenuUseCase
    extends StateNotifier<StateModel<RestaurantMenuEntity>> {
  final RestaurantRepository restaurantRepository;
  FetchRestaurantMenuUseCase(this.restaurantRepository) : super(StateModel());

  void call(
      {String? restaurantId,
      int? itemsCountLimit,
      String? localeIsoCode}) async {
    state = StateModel.loading();
    ResponseModel responseModel =
        await restaurantRepository.fetchRestaurantMenu(
            restaurantId: restaurantId,
            itemsCountLimit: itemsCountLimit,
            localeIsoCode: "en");

    if (responseModel.code == 200) {
      var restaurantMenuModel =
          RestaurantMenuModel.fromJson(responseModel.data);

      state = StateModel(
          state: DataState.SUCCESS,
          data: restaurantMenuModel.toEntity(),
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
