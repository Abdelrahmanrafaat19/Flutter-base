import '../../../../core/models/ResponseModel.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';
import '../../../../core/utils/typedefs.dart';
import '../models/location_model.dart';

class HomeRemoteDataSource {
  final HttpOperations _httpOps;

  HomeRemoteDataSource(this._httpOps);

  FutureResponseModel fetchCuisines({
    String? page,
    String? size,
    String? localeIsoCode,
    bool? fetchRestaurants,
    bool? featured,
    List<int>? cuisineIds,
  }) {
    return _httpOps.postData(
      authorized: true,
      endPoint: cuisineEndPoint,
      params: "?page=$page&size=$size&localeIsoCode=$localeIsoCode",
      data: {
        "fetchRestaurants": fetchRestaurants,
        "featured": featured,
        "cuisineIds": cuisineIds,
      },
    );
  }

  FutureResponseModel fetchCategories({
    String? page,
    String? size,
    String? localeIsoCode,
    bool? fetchRestaurants,
    bool? featured,
    List<int>? categoryIds,
    LocationModel? userLocation
  }) {
    return _httpOps.postData(
      endPoint: categoryEndPoint,
      params: "?page=$page&size=$size&localeIsoCode=$localeIsoCode",
      data: {
        "fetchRestaurants": fetchRestaurants,
        "featured": featured,
        "categoryIds": categoryIds,
        if (userLocation != null) "userLocation": userLocation,
      },
    );
  }
}
