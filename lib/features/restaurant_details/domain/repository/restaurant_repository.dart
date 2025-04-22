import '../../../../core/utils/typedefs.dart';

abstract class RestaurantRepository {

  // FutureResponseModel fetchRestaurantDetails(String restaurantId);

  FutureResponseModel fetchRestaurantMenu(String restaurantId,String localeIsoCode);

}