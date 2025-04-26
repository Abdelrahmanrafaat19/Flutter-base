import '../../../../core/utils/typedefs.dart';

abstract class RestaurantRepository {
  FutureResponseModel fetchRestaurantDetails(
    String restaurantId,
    String localeIsoCode,
  );

  FutureResponseModel fetchRestaurantMenu({
    String? restaurantId,
    int? itemsCountLimit,
    String? localeIsoCode,
  });

  FutureResponseModel fetchRestaurantReviews(
      {String? restaurantId,
      String? localeIsoCode,
      String? page,
      String? size});
}
