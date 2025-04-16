
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/typedefs.dart';
import '../../../permissions/data/model/address_model.dart';

abstract class CommonRepository{


  Future<List<dynamic>> getSuggestions(String input);

  Future<Address?> getLatLngFromPlaceId(String placeId);

  Future<Address?> getAddressFromLatLng(double lat, double lng);

  FutureResponseModel restaurantSearch({
    String? page,
    String? size,
    String? localeIsoCode,
    Map<String, dynamic>? requestBody
  });

  FutureResponseModel updateFavoriteRestaurantStatus({
    String? restaurantId,
    bool? addFavorite
  });
}