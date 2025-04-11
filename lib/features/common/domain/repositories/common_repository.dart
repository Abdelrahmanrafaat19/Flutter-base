
import '../../../../core/utils/typedefs.dart';

abstract class CommonRepository{
  FutureResponseModel restaurantSearch({
    String? page,
    String? size,
    String? localeIsoCode,
    Map<String, dynamic>? requestBody
  });

  FutureResponseModel updateFavoriteRestaurantStatus({
    String? restaurantId,
    bool? addFavorite
  });
}