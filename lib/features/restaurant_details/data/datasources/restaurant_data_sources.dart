import 'package:flutter_base/core/utils/typedefs.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';

class RestaurantDataSources {
  final HttpOperations _httpOps;
  RestaurantDataSources(this._httpOps);

  FutureResponseModel fetchRestaurantDetails(
      String restaurantId, String localeIsoCode) {
    return _httpOps.getData(
        endPoint: "$restaurantDetailsEndPoint/$restaurantId",
        params: "?localeIsoCode=$localeIsoCode");
  }

  FutureResponseModel fetchRestaurantMenu(
      {String? restaurantId, int? itemsCountLimit, String? localeIsoCode}) {
    String params = "?localeIsoCode=$localeIsoCode${itemsCountLimit != null ? "&itemsCountLimit=$itemsCountLimit" : ""}";

    return _httpOps.getData(
      endPoint: "$restaurantMenusEndPoint/$restaurantId",
      params: params,
    );
  }

  FutureResponseModel fetchRestaurantReviews(
      {String? restaurantId,
      String? localeIsoCode,
      String? page,
      String? size}) {
    return _httpOps.getData(
        endPoint: "$restaurantReviewsEndPoint/$restaurantId",
        params: "?localeIsoCode=$localeIsoCode&page=$page&size=$size");
  }
}
