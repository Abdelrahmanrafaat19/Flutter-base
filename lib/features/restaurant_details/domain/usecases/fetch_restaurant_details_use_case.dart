import 'package:flutter_base/core/models/ResponseModel.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/restaurant_details/data/models/restaurant_model.dart';
import 'package:flutter_base/features/restaurant_details/domain/entities/restaurant_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/restaurant_repository.dart';

class FetchRestaurantDetailsUseCase extends StateNotifier<StateModel<RestaurantDetailsEntity>>{
  final RestaurantRepository restaurantRepository;
  FetchRestaurantDetailsUseCase(this.restaurantRepository):super(StateModel());

  void call(String restaurantId,String localeIsoCode)async{
    state = StateModel.loading();

    ResponseModel responseModel = await restaurantRepository.fetchRestaurantDetails(restaurantId,localeIsoCode);

    if(responseModel.code == 200){
      RestaurantDetailsEntity restaurantDetailsEntity =
          RestaurantModel.fromJson(responseModel.data).toRestaurantDetailsEntity();

      state = StateModel.success(restaurantDetailsEntity,message: responseModel.message);
    }else{
      state = StateModel(
        state: DataState.ERROR,
        message: responseModel.message,
        errors: responseModel.errors
      );
    }

  }
  void updateRestaurantFavoriteState(RestaurantDetailsEntity? restaurant){
    state = StateModel.success(restaurant?.copyWith(isFavorite: !(restaurant.isFavorite ?? false)));
  }
}