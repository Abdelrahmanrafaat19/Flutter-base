import 'package:flutter_base/core/utils/typedefs.dart';

import '../../domain/repository/restaurant_repository.dart';
import '../datasources/restaurant_data_sources.dart';

class RestaurantRepositoryImp extends RestaurantRepository {
  final RestaurantDataSources _dataSources;
  RestaurantRepositoryImp(this._dataSources);

  // @override
  // FutureResponseModel fetchRestaurantDetails(String restaurantId) {
  //
  // }

  @override
  FutureResponseModel fetchRestaurantMenu(
      String restaurantId, String localeIsoCode) {
    return _dataSources.fetchRestaurantMenu(restaurantId, localeIsoCode);
  }
}
