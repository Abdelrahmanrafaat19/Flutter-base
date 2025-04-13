import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';
import '../../../../core/utils/typedefs.dart';
import 'package:http/http.dart' as http;

class CommonRemoteDataSource {
  final HttpOperations _httpOps;

  CommonRemoteDataSource(this._httpOps);

  FutureResponseModel restaurantSearch({
    String? page,
    String? size,
    String? localeIsoCode,
    Map<String, dynamic>? requestBody
  }) {
    return _httpOps.postData(
      endPoint: restaurantSearchEndPoint,
      params: "?page=$page&size=$size&localeIsoCode=$localeIsoCode",
      data: requestBody,
    );
  }

  FutureResponseModel updateFavoriteRestaurantStatus({
    String? restaurantId,
    bool? addFavorite
  }) {
    return _httpOps.postData(
      endPoint: favoriteRestaurantsEndPoint,
      data: {
        "restaurantId": restaurantId,
        "addFavorite": addFavorite
      },
    );
  }

  Future<List<dynamic>> fetchSuggestions(String input) async {
    final url = "$mainMapUrl$placesAutocompleteEndPoint?input=$input&key=$googleApiKey&components=country:eg";
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    if (json['status'] == 'OK') {
      return json['predictions'];
    } else {
      throw Exception(json['status']);
    }
  }

  Future<LatLng?> fetchPlaceDetails(String placeId) async {
    final url = "$mainMapUrl$placesDetailsEndPoint?place_id=$placeId&key=$googleApiKey";
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    if (json['status'] == 'OK') {
      final location = json['result']['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];
      return LatLng(lat, lng);
    } else {
      throw Exception(json['status']);
    }
  }
}
