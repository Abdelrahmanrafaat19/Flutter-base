import '../../../../core/utils/typedefs.dart';
import '../../../restaurant_details/data/models/location_model.dart';

abstract class HomeRepository {
  FutureResponseModel fetchCuisines({
    String? page,
    String? size,
    String? localeIsoCode,
    bool? fetchRestaurants,
    bool? featured,
    List<int>? cuisineIds,
  });

  FutureResponseModel fetchCategories({
    String? page,
    String? size,
    String? localeIsoCode,
    bool? fetchRestaurants,
    bool? featured,
    List<int>? categoryIds, LocationModel? userLocation
  });
}
