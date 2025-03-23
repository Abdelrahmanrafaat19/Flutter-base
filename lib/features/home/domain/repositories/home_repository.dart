import '../../../../core/utils/typedefs.dart';

abstract class HomeRepository {
  FutureResponseModel fetchCuisines({
    String? page,
    String? size,
    String? localeIsoCode,
    bool? fetchRestaurants,
    bool? featured,
    List<int>? categoryIds,
  });

  FutureResponseModel fetchCategories({
    String? page,
    String? size,
    String? localeIsoCode,
    bool? fetchRestaurants,
    bool? featured,
    List<int>? categoryIds,
  });
}
