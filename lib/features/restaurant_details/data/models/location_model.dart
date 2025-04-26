import '../../domain/entities/location_entity.dart';

class LocationModel {
  final String? lat;
  final String? lon;

  LocationModel({this.lat, this.lon});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
  LocationEntity toEntity() => LocationEntity(lat: lat, lon: lon);
}
