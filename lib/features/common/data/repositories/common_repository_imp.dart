import 'package:flutter_base/core/utils/typedefs.dart';
import 'package:flutter_base/features/permissions/data/model/address_model.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

import '../../domain/repositories/common_repository.dart';
import '../data_sources/common_data_sources.dart';

class CommonRepositoryImp extends CommonRepository {
  final CommonRemoteDataSource _commonRemoteDataSource;

  CommonRepositoryImp(this._commonRemoteDataSource);
  @override
  FutureResponseModel restaurantSearch(
      {String? page,
      String? size,
      String? localeIsoCode,
      Map<String, dynamic>? requestBody}) {
    return _commonRemoteDataSource.restaurantSearch(
        page: page,
        size: size,
        localeIsoCode: localeIsoCode,
        requestBody: requestBody);
  }

  @override
  FutureResponseModel updateFavoriteRestaurantStatus(
      {String? restaurantId, bool? addFavorite}) {
    return _commonRemoteDataSource.updateFavoriteRestaurantStatus(
        restaurantId: restaurantId, addFavorite: addFavorite);
  }

  @override
  Future<List<dynamic>> getSuggestions(String input) {
    return _commonRemoteDataSource.fetchSuggestions(input);
  }

  @override
  Future<Address?> getLatLngFromPlaceId(String placeId) {
    return _commonRemoteDataSource.fetchPlaceDetails(placeId);
  }

  @override
  Future<Address?> getAddressFromLatLng(double lat, double lng) {
    return _commonRemoteDataSource.getAddressFromLatLng(lat, lng);
  }
}
