import 'package:flutter_base/core/utils/typedefs.dart';
import 'package:flutter_base/features/search/data/data_source/restaurant_data_source.dart';
import 'package:flutter_base/features/search/domain/repositories/restaurant_repo.dart';

class RestaurantRepoImple implements RestaurantRepo {
  final RestaurantDataSource restaurantDataSource;

  RestaurantRepoImple(this.restaurantDataSource);

  @override
  FutureResponseModel fetchAllRestaurantData({int? page = 0, int? size = 10}) {
    return restaurantDataSource.fetchAllRestaurantData(
      page: page,
      size: size,
    );
  }

  @override
  FutureResponseModel searchOnRestaurant(
      {int? page = 0,
      int? size = 10,
      String? localeIsoCode = "en",
      String? restaurantName,
      String? cuisine,
      String? restaurantPhone,
      int? categoryId,
      int? minRating,
      bool? isOpen}) {
   return restaurantDataSource.searchOnRestaurant(
     page: page,
     size: size,
     categoryId: categoryId,
     cuisine: cuisine,
     minRating: minRating,
     isOpen: isOpen,
     localeIsoCode: localeIsoCode,
     restaurantName: restaurantName,
     restaurantPhone: restaurantPhone,
   );
  }
}
