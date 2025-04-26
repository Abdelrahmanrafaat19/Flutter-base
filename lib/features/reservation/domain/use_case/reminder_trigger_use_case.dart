import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../../data/models/reservation_data_model.dart';
import '../../data/models/reserved_restaurant_model.dart';
import '../entities/fetch_user_reservation_entity.dart';
import '../repositories/reservation_resturant_repo.dart';

class ReminderTriggerUseCase
    extends StateNotifier<StateModel<ReservedRestaurantEntity>> {
  final Ref ref;
  final ReservationResturantRepo _reservationResturantRepo;

  ReminderTriggerUseCase(this.ref, this._reservationResturantRepo)
      : super(StateModel());

  void call({
    required String restaurantID,
    required bool flag,
  }) async {
    state = StateModel.loading();

    ResponseModel responseModel =
        await _reservationResturantRepo.reminderTriggerReservationMethod(
      restaurantID: restaurantID,
      flag: flag,
    );

    if (responseModel.code == 200) {
      ReservedRestaurantEntity reminderTriggerData = toReservedRestaurantEntity(
          ReservedRestaurantModel.fromJson(responseModel.data));

      state = StateModel(
          state: DataState.SUCCESS,
          data: reminderTriggerData,
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
