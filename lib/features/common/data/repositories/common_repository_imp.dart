import 'package:flutter_base/core/utils/typedefs.dart';

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
}
