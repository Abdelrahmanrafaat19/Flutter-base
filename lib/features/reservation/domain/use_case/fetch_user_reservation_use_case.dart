import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../../data/models/reserved_restaurant_model.dart';
import '../entities/fetch_user_reservation_entity.dart';
import '../repositories/reservation_resturant_repo.dart';

class FetchUserReservationUseCase extends StateNotifier<StateModel<List<ReservedRestaurantEntity>>> {
  final Ref ref;
  final ReservationResturantRepo _reservationResturantRepo;
  FetchUserReservationUseCase(this.ref, this._reservationResturantRepo) : super(StateModel());

  void call({
    String? page = "0",
    String? size = "6",
  }) async {
    state = StateModel.loading();

    ResponseModel responseModel = await _reservationResturantRepo.fetchReservedMethod(
        page: page,
        size: size,);

    if (responseModel.code == 200) {
      List<ReservedRestaurantEntity> cuisines = (responseModel.data as List)
          .map((item) => toReservedRestaurantEntity(ReservedRestaurantModel.fromJson(item)))
          .toList();

      state = StateModel(
          state: DataState.SUCCESS,
          data: cuisines,
          message: responseModel.message);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}