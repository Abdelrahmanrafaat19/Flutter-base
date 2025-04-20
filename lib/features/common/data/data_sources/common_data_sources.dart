import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';
import '../../../../core/utils/typedefs.dart';
import 'package:http/http.dart' as http;

import '../../../permissions/data/model/address_model.dart';

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

  Future<Address?> fetchPlaceDetails(String placeId) async {
    final url = "$mainMapUrl$placesDetailsEndPoint?place_id=$placeId&key=$googleApiKey";
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    if (json['status'] == 'OK') {
      final location = json['result']['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];
      final description = location['formatted_address'] ?? location['name'] ?? '';

      return Address(
        placeName: location['name'] ?? '',
        latitude: lat,
        longitude: lng,
        description: description,
      );
    } else {
      throw Exception(json['status']);
    }
  }

  Future<Address?> getAddressFromLatLng(double lat, double lng) async {
    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          String formattedAddress = data['results'][0]['formatted_address'];
          print("Google Address: $formattedAddress");
          return Address(placeName: formattedAddress, latitude: lat, longitude: lng, description: formattedAddress);
        } else {
          print("No results found");
          return null;
        }
      } else {
        print("Failed to fetch address. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }


}
