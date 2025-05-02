import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';
import '../../../../core/utils/typedefs.dart';
import '../models/reservation_data_model.dart';

class ReservedRestaurantDataSource {
  final HttpOperations _httpOps;

  ReservedRestaurantDataSource(this._httpOps);

  FutureResponseModel fetchReservedMethod({
    String? page,
    String? size,
  }) {
    return _httpOps.getData(
      authorized: true,
      endPoint: fetchUserReserved,
      params: "?page=$page&size=$size",
    );
  }

  FutureResponseModel createReservationMethod({
    String? page,
    String? size,
    required String restaurantID,
    required ReversationDataModel reservationData,
  }) {
    return _httpOps.postData(
        authorized: true,
        endPoint: "$createReservationEndPoint$restaurantID",
        params: "?page=$page&size=$size",
        data: {
          "reservationDate": reservationData.reservationDate,
          "guestCount": reservationData.guestCount,
          "occasion": reservationData.occasion,
          "guestName": reservationData.guestName,
          "guestPhone": reservationData.guestPhone
        });
  }

  FutureResponseModel fetchReservationInformationMethod({
    required String restaurantID,
  }) {
    return _httpOps.getData(
      authorized: true,
      endPoint: "restaurant/$restaurantID/ReservationInformation",
    );
  }
  FutureResponseModel fetchReservationCostMethod({
    required String restaurantID,
    required int guestCount
  }) {
    return _httpOps.getData(
      authorized: true,
      endPoint: "restaurant/$restaurantID/ReservationCosts",
      params: "?guestsCount=$guestCount"
    );
  }

  FutureResponseModel fetchSingleReservationMethod({
    String? page,
    String? size,
    required String restaurantID,
  }) {
    return _httpOps.getData(
      authorized: true,
      endPoint: "$createReservationEndPoint$restaurantID",
      params: "?page=$page&size=$size",
    );
  }

  FutureResponseModel reminderTriggerReservationMethod({
    required String restaurantID,
    required bool flag,
  }) {
    return _httpOps.putData(
      authorized: true,
      endPoint: "$remiderTriggerEndPoint$restaurantID",
      params: "?reminderFlag=$flag",
    );
  }
  FutureResponseModel fetchSingle2ReservationMethod({
    String? page,
    String? size,
    required String restaurantID,
  }) {
    return _httpOps.getData(
      authorized: true,
      endPoint: "$reservationEndPoint$restaurantID",

    );
  }
}
