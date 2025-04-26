import 'package:flutter_base/features/reservation/data/models/avilable_time_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../entities/fetch_user_reservation_entity.dart';
import '../repositories/reservation_resturant_repo.dart';

class FetchAvaialbleMealTimeUseCase
    extends StateNotifier<StateModel<AvaliableTimeModel>> {
  final Ref ref;
  final ReservationResturantRepo _reservationResturantRepo;

  FetchAvaialbleMealTimeUseCase(this.ref, this._reservationResturantRepo)
      : super(StateModel());

  void call({
    String? page = "0",
    String? size = "6",
    required String restaurantID,
  }) async {
    state = StateModel.loading();

    ResponseModel responseModel =
        await _reservationResturantRepo.fetchrReservationInformationMethod(
      restaurantID: restaurantID,
    );

    if (responseModel.code == 200) {
      AvaliableTimeModel avaliableTimeModel =
          AvaliableTimeModel.fromJson(responseModel.data);

      state = StateModel(
          state: DataState.SUCCESS,
          data: avaliableTimeModel,
          message: responseModel.message);
    } else {
      state = StateModel(
        state: DataState.ERROR,
        message: responseModel.message,
        errors: responseModel.errors,
      );
    }
  }
}
