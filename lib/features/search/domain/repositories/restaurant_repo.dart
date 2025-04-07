import '../../../../core/utils/typedefs.dart';

abstract class RestaurantRepo {
  FutureResponseModel fetchAllRestaurantData({
    int? page = 0,
    int? size = 10,
  });
  FutureResponseModel searchOnRestaurant({
    int? page = 0,
    int? size = 10,
    String? localeIsoCode = "en",
    String? restaurantName,
    String? cuisine,
    String? restaurantPhone,
    int? categoryId,
    int? minRating,
    bool? isOpen,
  });
  FutureResponseModel searchRestaurantByName({
    int? page = 0,
    int? size = 10,
    Map<String, dynamic>? requestBody
  });
}
