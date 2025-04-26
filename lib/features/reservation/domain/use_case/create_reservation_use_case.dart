import 'package:flutter_base/features/reservation/data/models/reserved_restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../../data/models/reservation_data_model.dart';
import '../entities/fetch_user_reservation_entity.dart';
import '../repositories/reservation_resturant_repo.dart';

class CreateReservationUseCase
    extends StateNotifier<StateModel<ReservedRestaurantEntity>> {
  final Ref ref;
  final ReservationResturantRepo _reservationResturantRepo;

  CreateReservationUseCase(this.ref, this._reservationResturantRepo)
      : super(StateModel());

  void call({
    String? page = "0",
    String? size = "6",
    required String restaurantID,
    required ReversationDataModel reservationData,
  }) async {
    state = StateModel.loading();

    ResponseModel responseModel =
        await _reservationResturantRepo.createReservationMethod(
            page: page,
            size: size,
            restaurantID: restaurantID,
            reservationData: reservationData);

    if (responseModel.code == 200) {
      ReservedRestaurantEntity reservedRestaurantEntity =
          toReservedRestaurantEntity(
              ReservedRestaurantModel.fromJson(responseModel.data));

      state = StateModel(
          state: DataState.SUCCESS,
          data: reservedRestaurantEntity,
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
