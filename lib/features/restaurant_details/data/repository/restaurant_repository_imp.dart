import 'package:flutter_base/core/utils/typedefs.dart';

import '../../domain/repository/restaurant_repository.dart';
import '../datasources/restaurant_data_sources.dart';

class RestaurantRepositoryImp extends RestaurantRepository {
  final RestaurantDataSources _dataSources;
  RestaurantRepositoryImp(this._dataSources);

  @override
  FutureResponseModel fetchRestaurantDetails(
      String restaurantId, String localeIsoCode) {
    return _dataSources.fetchRestaurantDetails(restaurantId, localeIsoCode);
  }

  @override
  FutureResponseModel fetchRestaurantMenu(
      {String? restaurantId, int? itemsCountLimit, String? localeIsoCode}) {
    return _dataSources.fetchRestaurantMenu(
        restaurantId: restaurantId,
        itemsCountLimit: itemsCountLimit,
        localeIsoCode: localeIsoCode);
  }

  @override
  FutureResponseModel fetchRestaurantReviews(
      {String? restaurantId,
      String? localeIsoCode,
      String? page,
      String? size}) {
    return _dataSources.fetchRestaurantReviews(
        restaurantId: restaurantId,
        localeIsoCode: localeIsoCode,
        page: page,
        size: size);
  }
}
