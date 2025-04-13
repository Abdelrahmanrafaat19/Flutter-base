import 'package:dio/dio.dart';

import '../../permissions/data/model/address_model.dart';



class AddressService {
  final Dio _dio = Dio();
  final String _apiKey = 'AIzaSyAIhooYpv80pRyeAhyNzAyb4YGCmkTUlXA';

  Future<List<Address>> fetchSuggestions(String input) async {
    final autoCompleteUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    try {
      final response = await _dio.get(autoCompleteUrl, queryParameters: {
        'input': input,
        'key': _apiKey,
      });

      final predictions = response.data['predictions'] as List<dynamic>;

      List<Address> addresses = [];

      for (var item in predictions) {
        final prediction = item as Map<String, dynamic>;
        final placeId = prediction['place_id'];

        final latLng = await _getLatLngFromPlaceId(placeId);
        if (latLng != null) {
          addresses.add(Address.fromJsonWithLatLng(
              prediction, latLng['lat']!, latLng['lng']!));
        }
      }

      return addresses;
    } catch (e) {
      print('Error fetching place suggestions: $e');
      return [];
    }
  }

  Future<Map<String, double>?> _getLatLngFromPlaceId(String placeId) async {
    final placeDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json';

    try {
      final response = await _dio.get(placeDetailsUrl, queryParameters: {
        'place_id': placeId,
        'key': _apiKey,
      });

      if (response.statusCode == 200) {
        final location = response.data['result']['geometry']['location'];
        return {
          'lat': location['lat'],
          'lng': location['lng'],
        };
      }
    } catch (e) {
      print('Error getting lat/lng: $e');
    }

    return null;
  }
}