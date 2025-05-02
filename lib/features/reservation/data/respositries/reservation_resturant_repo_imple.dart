import 'package:flutter_base/core/utils/typedefs.dart';
import 'package:flutter_base/features/reservation/data/models/reservation_data_model.dart';

import '../../domain/repositories/reservation_resturant_repo.dart';
import '../data_source/reserved_restaurant_data_source.dart';

class ReservationResturantRepoImple implements ReservationResturantRepo {
  final ReservedRestaurantDataSource _reservedRestaurantDataSource;

  ReservationResturantRepoImple(this._reservedRestaurantDataSource);

  @override
  FutureResponseModel fetchReservedMethod({
    String? page,
    String? size,
  }) {
    return _reservedRestaurantDataSource.fetchReservedMethod(
        page: page, size: size);
  }

  @override
  FutureResponseModel createReservationMethod(
      {String? page,
      String? size,
      required String restaurantID,
      required ReversationDataModel reservationData}) {
    return _reservedRestaurantDataSource.createReservationMethod(
        restaurantID: restaurantID, reservationData: reservationData);
  }

  @override
  FutureResponseModel fetchSingleReservationMethod({
    String? page,
    String? size,
    required String restaurantID,
  }) {
    return _reservedRestaurantDataSource.fetchSingleReservationMethod(
      page: page,
      size: size,
      restaurantID: restaurantID,
    );
  }

  @override
  FutureResponseModel reminderTriggerReservationMethod(
      {required String restaurantID, required bool flag}) {
    return _reservedRestaurantDataSource.reminderTriggerReservationMethod(
      restaurantID: restaurantID,
      flag: flag,
    );
  }

  @override
  FutureResponseModel fetchrReservationInformationMethod(
      {required String restaurantID}) {
    return _reservedRestaurantDataSource.fetchReservationInformationMethod(
      restaurantID: restaurantID,
    );
  }

  @override
  FutureResponseModel fetchReservationCostMethod(
      {required String restaurantID, required int guestCount}) {
    return _reservedRestaurantDataSource.fetchReservationCostMethod(
        restaurantID: restaurantID, guestCount: guestCount);
  }

  @override
  FutureResponseModel fetchSingle2ReservationMethod(
      {String? page, String? size, required String restaurantID}) {
    return _reservedRestaurantDataSource.fetchSingle2ReservationMethod(
        restaurantID: restaurantID);
  }
}
