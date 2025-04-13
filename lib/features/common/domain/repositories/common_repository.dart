
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/typedefs.dart';

abstract class CommonRepository{


  Future<List<dynamic>> getSuggestions(String input);

  Future<LatLng?> getLatLngFromPlaceId(String placeId);

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