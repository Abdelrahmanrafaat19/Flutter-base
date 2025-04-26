import '../../../../core/utils/typedefs.dart';
import '../../data/models/reservation_data_model.dart';

abstract class ReservationResturantRepo {
  FutureResponseModel fetchReservedMethod({
    String? page,
    String? size,
  });

  FutureResponseModel createReservationMethod({
    String? page,
    String? size,
    required String restaurantID,
    required ReversationDataModel reservationData,
  });

  FutureResponseModel fetchSingleReservationMethod({
    String? page,
    String? size,
    required String restaurantID,
  });

  FutureResponseModel reminderTriggerReservationMethod({
    required String restaurantID,
    required bool flag,
  });
  FutureResponseModel fetchrReservationInformationMethod({
    required String restaurantID,

  });
  FutureResponseModel fetchReservationCostMethod({
    required String restaurantID,
    required int guestCount
  });
}
