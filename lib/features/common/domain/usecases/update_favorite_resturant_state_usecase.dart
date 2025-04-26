import 'package:flutter_base/features/common/domain/repositories/common_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../../../home/domain/entities/restaurant_entity.dart';

class UpdateFavoriteRestaurantStateUseCase
    extends StateNotifier<StateModel<int>> {
  final Ref ref;
  final CommonRepository _repository;
  UpdateFavoriteRestaurantStateUseCase(this.ref, this._repository) : super(StateModel());

  void call({
    int? restaurantId,
    bool? addFavorite
  }) async {

    state = StateModel.loading();

    ResponseModel responseModel = await _repository.updateFavoriteRestaurantStatus(
        restaurantId: restaurantId.toString(),addFavorite: addFavorite);

    if (responseModel.code == 200) {
        state = StateModel.success(restaurantId);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}
