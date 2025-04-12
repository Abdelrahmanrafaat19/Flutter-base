import 'package:flutter_base/core/network/api_endpoints.dart';

import '../../../../core/network/http_operation.dart';
import '../../../../core/utils/typedefs.dart';

class RestaurantDataSource {
  final HttpOperations _httpOps;

  RestaurantDataSource(this._httpOps);

  FutureResponseModel fetchAllRestaurantData({int? page = 0, int? size = 10}) {
    return _httpOps.postData(
      endPoint: fetchAllRestaurantEndPoint,
      authorized: true,
      params: "?page=$page&size=$size",
    );
  }

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
  }) {
    return _httpOps.postData(
      endPoint: restaurantSearchEndPoint,
      authorized: true,
      params: "?page=$page&size=$size&localeIsoCode=$localeIsoCode",
      data: {
        "restaurant": restaurantName,
        "restaurantPhone": restaurantPhone,
        "cuisine": cuisine,
        "categoryId": categoryId,
        "restaurantCertificates": "string",
        "minRating": minRating,
        "isOpen": isOpen,
      },
    );
  }

  FutureResponseModel searchRestaurantByName({
    int? page = 0,
    int? size = 10,
    Map<String, dynamic>? requestBody
  }){
    return _httpOps.postData(
      endPoint: searchRestaurantNameEndPoint,
      data:requestBody,
    );
  }
}
