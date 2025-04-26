import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../../data/models/cost_model.dart';
import '../repositories/reservation_resturant_repo.dart';

class GetReservationCostUseCase extends StateNotifier<StateModel<CostModel>> {
  final Ref ref;
  final ReservationResturantRepo _reservationResturantRepo;

  GetReservationCostUseCase(this.ref, this._reservationResturantRepo)
      : super(StateModel());

  void call({required String restaurantID, required int guestCount}) async {
    state = StateModel.loading();

    ResponseModel responseModel = await _reservationResturantRepo
        .fetchReservationCostMethod(
        restaurantID: restaurantID, guestCount: guestCount);

    if (responseModel.code == 200) {
      CostModel costData = CostModel.fromJson(responseModel.data);

      state = StateModel(
          state: DataState.SUCCESS,
          data: costData,
          message: responseModel.message);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}