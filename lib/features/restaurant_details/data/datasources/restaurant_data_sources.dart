import 'package:flutter_base/core/utils/typedefs.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';

class RestaurantDataSources {
  final HttpOperations _httpOps;
  RestaurantDataSources(this._httpOps);

  //   FutureResponseModel fetchRestaurantDetails(String restaurantId){
  //   return _httpOps.getData(endPoint: );
  // }

  FutureResponseModel fetchRestaurantMenu(String restaurantId,String localeIsoCode) {
    return _httpOps.getData(
      endPoint: "$restaurantMenusEndPoint/$restaurantId",
      params: "?localeIsoCode=$localeIsoCode"
    );
  }
}
